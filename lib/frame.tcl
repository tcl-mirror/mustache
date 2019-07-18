## -*- tcl -*-
# # ## ### ##### ######## ############# #####################
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache::frame 0
# Meta author      {Andreas Kupries}
# Meta category    Template Processing
# Meta description Implementation of mustache, data frames
# Meta location    http:/core.tcl.tk/akupries/mustache
# Meta platform    tcl
# Meta summary     Mustache, logic-less templates
# Meta subject     mustache template logic-less
# Meta require     {Tcl 8.5-}
# Meta require     debug
# Meta require     debug::caller
# @@ Meta End

package require Tcl 8.5
package require TclOO
package require debug
package require debug::caller

package provide mustache::frame 0

# # ## ### ##### ######## ############# #####################

namespace eval ::mustache {
    namespace export frame
    namespace ensemble create
}
namespace eval ::mustache::frame {
    namespace export scalar mapping sequence fromTags
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/frame
debug level  mustache/frame
debug prefix mustache/frame {[debug caller] | }

# # ## ### ##### ######## ############# #####################
## This command converts a tagged data structure as delivered by
## TclYAML's readTags into an equivalent hierarchy of frame objects.
## It does this by using the tags as commands which convert their
## argument(s)

proc ::mustache::frame::fromTags {spec} {
    debug.mustache/frame {}
    return [FT {*}$spec]
}

namespace eval ::mustache::frame::FT {
    namespace export scalar sequence mapping
    namespace ensemble create
}

proc ::mustache::frame::FT::scalar {v} {
    debug.mustache/frame {}
    mustache frame scalar new $v
}

proc ::mustache::frame::FT::sequence {v} {
    debug.mustache/frame {}
    mustache frame sequence new [arg-sequence $v]
}

proc ::mustache::frame::FT::mapping {v} {
    debug.mustache/frame {}
    mustache frame mapping new [arg-mapping $v]
}

# # ## ### ##### ######## ############# #####################

proc ::mustache::frame::FT::arg-sequence {v} {
    debug.mustache/frame {}
    lmap el $v {
	debug.mustache/frame {- ($el)}
	{*}$el
    }
}

proc ::mustache::frame::FT::arg-mapping {v} {
    debug.mustache/frame {}
    set tmp {}
    foreach {k val} $v {
	set k [lindex $k end]	;# assumed scalar
	debug.mustache/frame {- ($k) --> ($val)}
	dict set tmp $k [{*}$val]
    }
    return $tmp
}

# # ## ### ##### ######## ############# #####################
## API - Frame methods
# - field K	Get frame for field with name K
# - has? K	Do you know a field with name K
# - iter C S    Iterate your children, run script S with each child
#               as dot in C.
# - iterable?   Are you a non-empty list ? (check nil? first)
# - nil?        Are you false, or an empty list ?
# - value       Return your value

# # ## ### ##### ######## ############# #####################

oo::class create ::mustache::frame::scalar {
    # Scalar value.
    
    constructor {val} {
	debug.mustache/frame {}
	set value $val
	return
    }

    destructor {
	debug.mustache/frame {}
	return
    }
    
    method field {k} {
	debug.mustache/frame {}
	return -code error \
	    -errorcode {MUSTACHE FRAME SCALAR FIELD} \
	    "Scalar has no fields"
    }
    
    method has? {k} {
	debug.mustache/frame {}
	return 0
    }

    method iter {context script} {
	debug.mustache/frame {}
	return -code error \
	    -errorcode {MUSTACHE FRAME SCALAR ITER} \
	    "Scalar cannot be iterated over"
    }
    
    method iterable? {} {
	debug.mustache/frame {}
	return 0
    }

    method nil? {} {
	debug.mustache/frame {}
	# Yes for empty string, or a boolean and representing false.
	expr {($value eq {}) || ([string is boolean -strict $value] && !$value)}
    }

    method value {} {
	debug.mustache/frame {}
	return $value
    }
    
    # - - -- --- ----- -------- -------------
    ## State variables

    variable value	;# Frame data

    # - - -- --- ----- -------- -------------
}

# # ## ### ##### ######## ############# #####################

oo::class create ::mustache::frame::sequence {
    # List/sequence value. Of frames.
    
    constructor {val} {
	# val :: list (frame-object)
	# Container owns the objects given to it.
	debug.mustache/frame {}
	set value $val
	return
    }

    destructor {
	# Container destroys the owned elements.
	debug.mustache/frame {}
	foreach el $value { $el destroy }
	return
    }
    
    method field {k} {
	debug.mustache/frame {}
	return -code error \
	    -errorcode {MUSTACHE FRAME SEQUENCE FIELD} \
	    "Sequence has no fields"
    }
    
    method has? {k} {
	debug.mustache/frame {}
	return 0
    }

    method iter {context script} {
	debug.mustache/frame {}
	foreach el $value {
	    $context push $el
	    uplevel 1 $script
	    $context pop
	}
	return
    }
    
    method iterable? {} {
	debug.mustache/frame {}
	expr {!![llength $value]}
    }

    method nil? {} {
	debug.mustache/frame {}
	# Yes for an empty sequence.
	expr {![llength $value]}
    }

    method value {} {
	debug.mustache/frame {}
	# stringify - memoize ?
	return [lmap v $value { $v value }]
    }
    
    # - - -- --- ----- -------- -------------
    ## State variables

    variable value	;# Frame data (list, sequence)

    # - - -- --- ----- -------- -------------
}

# # ## ### ##### ######## ############# #####################

oo::class create ::mustache::frame::mapping {
    # Dictionary/map value. Keys mapping to frames.
    
    constructor {val} {
	debug.mustache/frame {}
	# val :: dict (key -> frame-object)
	# Container owns the objects given to it.
	set value $val
	return
    }

    destructor {
	# Container destroys the owned elements.
	debug.mustache/frame {}
	dict for {k el} $value { $el destroy }
	return
    }

    method field {k} {
	debug.mustache/frame {}
	if {![my has? $k]} {
	    return -code error \
		-errorcode {MUSTACHE FRAME MAPPING FIELD} \
		"Field '$k' is not known"
	}
	return [dict get $value $k]
    }
    
    method has? {k} {
	debug.mustache/frame {}
	dict exists $value $k
    }

    method iter {context script} {
	debug.mustache/frame {}
	return -code error \
	    -errorcode {MUSTACHE FRAME MAPPING ITER} \
	    "Mapping cannot be iterated over"
    }
    
    method iterable? {} {
	debug.mustache/frame {}
	return 0
    }

    method nil? {} {
	debug.mustache/frame {}
	# Yes for an empty map.
	expr {![dict size $value]}
    }

    method value {} {
	debug.mustache/frame {}
	# stringify - memoize ?
	set r {}
	dict for {k v} $value { lappend r $k [$v value] }
	return $r
    }
    
    # - - -- --- ----- -------- -------------
    ## State variables

    variable value	;# Frame data (dictionary, map)

    # - - -- --- ----- -------- -------------
}

# # ## ### ##### ######## ############# #####################
return
