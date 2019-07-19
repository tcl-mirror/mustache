## -*- tcl -*-
# # ## ### ##### ######## #############
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache::parse 0
# Meta author      {Andreas Kupries}
# Meta category    Template Processing
# Meta description Implementation of mustache, parsing
# Meta location    http:/core.tcl.tk/akupries/mustache
# Meta platform    tcl
# Meta summary     Mustache, logic-less templates
# Meta subject     mustache template logic-less
# Meta require     {Tcl 8.5-}
# Meta require     debug
# Meta require     debug::caller
# @@ Meta End

package require Tcl 8.5
package require debug
package require debug::caller

package provide mustache::parse 0

# # ## ### ##### ######## #############

namespace eval ::mustache {
    namespace export parse
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/parse
debug level  mustache/parse
debug prefix mustache/parse {[debug caller] | }

# # ## ### ##### ######## #############
## API

proc mustache::parse {template {delim {}}} {
    debug.mustache/parse {}
    if {[llength [info level 0]] < 3} {
	set opener \{\{
	set closer \}\}
    } else {
	lassign $delim opener closer
    }
    #return [ParseL $template $opener $closer]
    return [ParseS [ParseL $template $opener $closer]]
}

# # ## ### ##### ######## #############
## Internals

proc mustache::ParseS {template} {
    debug.mustache/parse {}
    # The incoming template is a pre-parsed list of literals and tags.
    # Comments are gone, as are delimiter changes.

    # This procedure is responsible for three things
    ##
    # - Checking that opening and closing section tags match properly.
    # - Conversion of the linear token sequence into a proper tree.
    # - Transformation of dotted field sequences into proper nested
    #   sections.

    set tree  {} ; # tree at the current level of sections.
    set match {} ; # identifier of current open section.
    set mcmd  {} ; # command of current open section.
    set mpos  {} ; # index for start of current open section.
    set stack {} ; # stack of partials trees, for all open sections.
    #            ; # element :: list (tree match cmd pos)
    set lit   "" ; # accumulator of literal sequences

    foreach el $template {
	lassign $el cmd pos detail
	if {($cmd ne "lit") && [string length $lit]} {
	    # literal sequence has ended. push into tree
	    lappend tree [list lit $lit]
	    set lit ""
	}
	switch -exact -- $cmd {
	    lit {
		append lit $detail
	    }
	    var         -
	    var/escaped {
		# Check for dotted fields and transform into properly
		# nested sections. A field like a.b.c roughly
		# transforms into (*section a (*section.dot b (var*.dot c)))
		#
		# The `.dot` variants of `*section` and `var*` tags is
		# used to indicate that field search is restricted to
		# the previous field, it cannot be searched in the
		# general context. That unlimited search is limited to
		# the start of the dotted chain.
		#
		# Note that ParseL has already ensured that a field
		# will not start with a dot.

		if {[string first . $detail] >= 0} {
		    set args {}
		    set chain [lreverse [lassign [split $detail .] first]]
		    foreach field $chain {
			set el   [list $cmd.dot $pos $field {*}$args]
			set args [list [list $el]]
			set cmd  section
		    }
		    set el [list $cmd $pos $first {*}$args]
		}
		lappend tree $el
	    }
	    dot         -
	    dot/escaped -
	    partial { lappend tree $el }
	    section  -
	    isection {
		# Push current partial tree and match information
		lappend stack [list $tree $match $mcmd $mpos]
		# Start a new tree for this section.
		set tree  {}
		set match $detail
		set mcmd  $cmd
		set mpos  $pos

		#puts Z_////////////////////////
		#/D
		#puts Z_start\t$mcmd/$match
	    }
	    end {
		if {$detail ne $match} {
		    # Closing tag not matching the opener
		    E "Bad section closer '$detail' at index $pos, expected '$match', see index $mpos" \
			SECTION MISMATCH $detail $pos $match $mpos
		}
		# Add the now-complete tree to the previous partial
		# and make the partial current again.
		# Note, we expand dotted fields for the (i)section.
		# An exception is dot itself.
		if {($detail ne ".") &&
		    ([string first . $detail] >= 0)} {
		    set args  [list $tree]
		    set chain [lreverse [lassign [split $detail .] first]]
		    foreach field $chain {
			set node [list $mcmd.dot $mpos $field {*}$args]
			set args [list [list $node]]
			set mcmd section
		    }
		    set node [list $mcmd $mpos $first {*}$args]
		} else {
		    set node [list $mcmd $mpos $match $tree]
		}

		lassign [lindex $stack end] tree match mcmd mpos

		lappend tree $node

		set stack [lreplace $stack end end]

		#puts Z_restored\t$mcmd/$match/$mpos
		#/D
		#puts Z_////////////////////////
	    }
	}
    }

    # Close last literal sequence, if any.
    if {[string length $lit]} {
	lappend tree [list lit $lit]
    }

    # Tree elements
    # Leaf types
    # - 'dot'		pos _ignore_
    # - 'dot/escaped'	pos _ignore_
    # - 'lit'		text
    # - 'partial'	pos identifier
    # - 'var'		pos identifier
    # - 'var.dot'	pos identifier
    # - 'var/escaped'	pos identifier
    # - 'var/escaped.dot' pos identifier
    #
    # Node types
    # - 'isection'	pos identifier children
    # - 'isection.dot'	pos identifier children
    # - 'section'	pos identifier children
    # - 'section.dot'	pos identifier children
    #
    # where children :: list (node|leaf)
    #

    puts %*\t[join $tree \n%*\t]
    return $tree
}

proc mustache::/D {} {
    upvar 1 stack stack
    foreach el $stack {
	puts Z_#S\t[lreplace $el 0 0 ()]
    }
}

proc mustache::ParseL {template opener closer} {
    debug.mustache/parse {}

    set olen [string length $opener]
    set clen [string length $closer]
    ValidateDelimiters " at start"

    # ASSERT: olen > 0 && clen > 0

    # Phase I. Split the template into a series of literals and tags.
    set start  0
    set result {} ;# list of literals and tags.

    # Trim state for standalone tags.
    set standalone 0
    set max [string length $template]

    # :: list(literal|tag)
    # :: literal = list('lit' pos text)
    # :: tag     = list(cmd   pos param)

    puts "% % %% %%% %%%%% %%%%%%%%"

    while 1 {
	# start points to a location after a tag.
	debug.mustache/parse {@$start}
	puts "- - -- --- ----- -------- ------------- \\"
	puts "- @$start/$max"
	puts "- ([X [string range $template $start end]])"

	set tagstart [string first $opener $template $start]

        debug.mustache/parse {- $tagstart ($opener)}
	puts "- ($opener) @$tagstart"

	if {$tagstart < 0} {
	    # no tag intro found, remainder is literal
	    Lit $start [string range $template $start end]
	    puts "- STOP"
	    break
	}

	# tag intro, get preceding literal, if any
	set standalone no
	set litstart   $start
	set litprefix  [string range $template $start ${tagstart}-1]

	puts "- Prefix @  $litstart"
	puts "- Prefix Rw '[X $litprefix]'"

	# Strip leading whitespace. May be added back later.
	if {[regexp -indices -- {([ \t]+)$} $litprefix -> padding]} {
	    lassign $padding ps pe
	    set padding   [string range $litprefix {*}$padding]
	    set litprefix [string range $litprefix 0 ${ps}-1]

	    puts "- Prefix St '[X $litprefix]'"
	    puts "- Prefix Pd '[X $padding]' (${ps}..$pe)"
	} else {
	    set padding    ""
	    set ps [string length $litprefix]
	}

	# Determine if tag looks to be alone on the line.  For this we
	# look in the template, at the character just before the
	# padding.  We cannot look in the litprefix, because that may
	# not contain the EOL in question, due to having been skipped
	# by the suffix processing of the previous tag.

	set eolc [expr {$start + $ps - 1}]
	puts "- Prefix EL @$eolc ($start+$ps-1 '[X [string range $template ${eolc}-2 ${eolc}+2]]' ('[X [string index $template $eolc]]')"

	if {($eolc < 0) || ([string index $template $eolc] eq "\n")} {
	    puts "- Prefix !! Standalone"
	    set standalone yes
	}

	# Restore stripped whitespace if we are not at the beginning
	# of a new line.
	if {!$standalone} {
	    append litprefix $padding
	    set padding ""

	    puts "- Prefix Re '[X $litprefix]'"
	    puts "- Prefix Pd '[X $padding]'"
	}

	incr tagstart $olen

	# determine end of tag element
	set tagclose [string first $closer $template $tagstart]

	puts "- ($closer) @$tagclose"

	if {$tagclose < 0} {
	    E "Unclosed tag at index $tagstart" \
		MISSING CLOSE $tagstart
	}

	# Determine tag command.
	set cmd [CommandOf [string index $template $tagstart]]

	puts "- C $cmd"

	# Determine tag parameter
	if {$cmd ne "var/escaped"} {
	    incr tagstart ; # move beyond the command character
	}

	set param [string trim [string range $template $tagstart ${tagclose}-1]]

	puts "- P ([X $param])"

	# Parameter checks

	if {($cmd ne "comment") &&
	    ([string first \n $param] >= 0)} {
	    # Only comment tags are allowed to be multi-line.
	    E "Illegal multi-line $cmd tag, at index $tagstart" \
		ILLEGAL MULTILINE $cmd $tagstart
	}

	if {[string match var* $cmd] &&
	    ($param ne ".") &&
	    ([string index $param 0] eq ".")} {
	    E "Bad field '$param' beginning with dot, at index $tagstart" \
		ILLEGAL PARAM FIELD $tagstart $param
	}

	# Move starting point of next round beyond the current closer.
	set  start $tagclose
	incr start $clen
	if {$cmd eq "var/triple"} {
	    incr start
	    set cmd "var"
	}

	puts "- > $start"

	if {[string match var* $cmd] && ($param eq ".")} {
	    set cmd [string map {var dot} $cmd]
	}

	# Various special behaviours.

	# Set new delimiters.
	if {$cmd eq "delim"} {
	    # Note: We chop the last param character, is (expected to
	    # be) `=`, and is not part of the new delimiter.
	    set delim [split [string trim [string range $param 0 end-1]] { }]
puts "- D ($delim)"
	    # No lassign, have to handle padded internal space
	    set opener [lindex $delim 0]
	    set closer [lindex $delim end]
puts "  - O ($opener)"
puts "  - C ($closer)"
	    set olen [string length $opener]
	    set clen [string length $closer]
	    ValidateDelimiters
	}

	# If this tag is standing alone, i.e. everything else on this
	# line is whitespace, and we are not doing interpolation, then
	# all remaining whitespace after it is stripped. Otherwise we
	# re-add all padding we may have stored for the prefix, to the
	# prefix.

	if {$standalone && ($start < $max)} {
	    puts "- Suffix .. SkipCmd=[expr {$cmd ne "var"}]"
	    puts "- Suffix @  $start '[X [string range $template $start end]]'"
	    puts "- Suffix .. LeadEol=[regexp -start $start -indices -- {\A(\r?\n)} $template -> peek]"

	    if {($cmd ni {var var/escaped}) &&
		[regexp -start $start -indices -- {\A(\r?\n)} $template -> peek]} {
		puts "- Suffix s2 [expr {[lindex $peek end]+1}]"

		set  start [lindex $peek end]
		incr start
	    } else {
		puts "- Suffix .. Re-pad prefix '[X $padding]'"
		append litprefix $padding
	    }
	}

	Lit $litstart $litprefix

	# Hide special commands from the higher layers.
	if {$cmd in {delim comment}} {
	    continue
	}

	# Save token
	Tag $tagstart $cmd $param
    }

    puts "- - -- --- ----- -------- ------------- /"
    puts @\t[join [lmap x $result {
	lreplace $x end end [X [lindex $x end]]
    }] \n@\t]
    puts "- - -- --- ----- -------- ------------- *"

    return $result
}

# Standalone tags should not introduce empty lines.
# However just leading/trailing spaces should be kept.
# Tests:

# -------------- /1
# B \n    T \n A	comment:standalone,standalone.line.endings
# B \n         A
# -------------- /2
# B \n\s  T \n A	comment:indented.standalone
# B \n         A
# -------------- /3
#   \s    T \n A	comment:standalone.without.previous.line
#              A
# -------------- /4
# B \n\s  T		comment:standalone.without.newline
# B \n			4 is 1st half of 2, without any A(fter)
# -------------- /5
# B \s    T \n A	comment:indented.inline
# B \s    T \n A
# -------------- /6
# B \s    T \s A	comment:surrounding.whitespace
# B \s    T \s A
# --------------

# \n includes \r\n digraph.

proc mustache::X {x} {
    string map  [list \f \\f \v \\v \n \\n \r \\r { } \\s \t \\t] $x
}

proc mustache::CommandOf {c} {
    set map {
	"\{" var/triple
	"!"  comment
	"&"  var
	"#"  section
	"^"  isection
	"/"  end
	">"  partial
	"="  delim
    }
    if {[dict exists $map $c]} {
	return [dict get $map $c]
    }
    return var/escaped
}

proc ::mustache::ValidateDelimiters {{at {}}} {
    upvar 1 olen o clen c tagstart t
    if {$at eq {}} {
	set at " specified at index $t"
    } else {
	set at " $at"
    }
    if {!$o} { E "Empty opener$at" BAD OPENER }
    if {!$c} { E "Empty closer$at" BAD CLOSER }
    return
}

proc mustache::E {msg args} {
    return \
	-code error \
	-errorcode [linsert $args 0 MUSTACHE SYNTAX] \
	$msg
}

proc mustache::Lit {pos detail} {
    puts "- L @$pos ([X $detail])"
    upvar 1 result result
    lappend result [list lit $pos $detail]
    return
}

proc mustache::Tag {pos cmd detail} {
    puts "- T @$pos $cmd ([X $detail])"
    upvar 1 result result
    lappend result [list $cmd $pos $detail]
    return
}

# # ## ### ##### ######## #############
return
