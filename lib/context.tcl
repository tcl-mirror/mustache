## -*- tcl -*-
# # ## ### ##### ######## ############# #####################
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache::context 0
# Meta author      {Andreas Kupries}
# Meta category    Template Processing
# Meta description Implementation of mustache, context
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

package provide mustache::context 0

# # ## ### ##### ######## ############# #####################

namespace eval ::mustache {
    namespace export context
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/context
debug level  mustache/context
debug prefix mustache/context {[debug caller] | }

# # ## ### ##### ######## ############# #####################
## API

## Frame methods
# - field K	Get frame for field with name K
# - has? K	Do you know a field with name K
# - iter C S    Iterate your children, run script S with each child
#               as dot in C.
# - iterable?   Are you a non-empty list ? (check nil? first)
# - nil?        Are you false, or an empty list ?
# - value       Return your value

oo::class create ::mustache::context {

    # - - -- --- ----- -------- -------------
    ## State
    # - A Stack Of Frames
    # - A Current Frame (Top Of Stack) - Term "dot".
    # - The last frame searched for and found (name, and object)
    # - A dictionary of sub-ordinate named templates ready for inclusion.

    # - - -- --- ----- -------- -------------
    ## API
    # - focus K		Make field with name K the new "dot" (current focus)
    # - has? K		Do you know a field with name K
    # - iter S		Invoke S for all children of "dot"
    # - iterable?	Is "dot" a non-empty list ? (check nil? first)
    # - nil?		Is "dot" false, or an empty list ?
    # - pop		Return to previous "dot"
    # - push F		Make frame F the new "dot"
    # - template K	Get template ?(render structure) with name K
    # - template: K T	Declare template named K, and unparsed definition T.
    # - template? K	Do you know a template with name K
    # - value		Return "dot"'s value.

    # - - -- --- ----- -------- -------------
    ## API implementation
    
    constructor {rootframe} {
	debug.mustache/context {}
	my push $rootframe
	my __clear
	return
    }
    
    method focus {field} {
	debug.mustache/context {}
	if {$field ne $lastfield} {
	    if {![my has? $field]} {
		return -code error \
		    -errorcode {MUSTACHE CONTEXT NO FIELD} \
		    "Unable to focus on missing field $field"
	    }
	}
	my push $lastframe
	my __clear
	return
    }

    method has? {field} {
	debug.mustache/context {}
	foreach frame [lreverse $frames] {
	    if {![{*}$frame has? $field]} continue
	    __found $field [{*}$frame field $field]
	    return 1
	}
	return 0
    }

    # iter, iterable?, nil?, value
    # - While it would be nice, we cannot simply forward, as `dot` is
    #   dynamically changing.
    
    method iter {script} {
	debug.mustache/context {}
	{*}$dot iter [self] {
	    uplevel 1 $script
	}
    }
    
    method iterable? {} {
	debug.mustache/context {}
	{*}$dot iterable?
    }
    
    method nil? {} {
	debug.mustache/context {}
	{*}$dot nil?
    }

    method pop {} {
	debug.mustache/context {}
	set frames [lreplace $frames end end]
	set dot    [lindex   $frames end]
	return
    }

    method push {frame} {
	debug.mustache/context {}
	lappend frames $frame
	set     dot    $frame
	return
    }

    method template {name} {
	debug.mustache/context {}
	return [dict get $parts $name]
    }

    method template: {name template} {
	debug.mustache/context {}
	dict set parts $name $template
	return
    }

    method template? {name} {
	debug.mustache/context {}
	return [dict exists $parts $name]
    }

    method value {} {
	debug.mustache/context {}
	{*}$dot value
    }
    
    # - - -- --- ----- -------- -------------
    ## State variables

    variable frames	;# stack of frame(object)s, TOS at end
    variable dot	;# TOS frame(object)
    variable lastfield	;# Name   of last field/frame searched for and found.
    variable lastframe  ;# Object of ...
    variable parts	;# Map: name -> template (partials, includables)
    
    # - - -- --- ----- -------- -------------
    ## Internal helpers
    
    method __found {field frame} {
	set lastfield $field
	set lastframe $frame
    }
    method __clear {field frame} {
	my __found {} {}
    }

    # - - -- --- ----- -------- -------------
}

# # ## ### ##### ######## ############# #####################
return
