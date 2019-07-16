## -*- tcl -*-
# # ## ### ##### ######## #############
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache::parse 0
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
package require debug
package require debug::caller

package provide mustache::context 0

# # ## ### ##### ######## #############

namespace eval ::mustache {
    namespace export context
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/parse
debug level  mustache/parse
debug prefix mustache/parse {[debug caller] | }

# # ## ### ##### ######## #############
## API

# mustache context
##

# Methods
# - focus K	Make field with name K the new "dot" (current focus)
# - has? K	Do you know a field with name K

# - iterable?   Is "dot" a non-empty list ? (check nil? first)
# - nil?        Is "dot" false, or an empty list ?
# - pop         Return to previous "dot"
# - push F      Make frame F the new "dot"
# - value       Return "dot"'s value.
# - template? K Do you know a template with name K
# - template K  Get template render structure with name K
##
# Frame methods
# - field K	Get frame for field with name K
# - has? K	Do you know a field with name K
# - iter C S    Iterate your children, run script S with each child
#               as dot in C.
# - iterable?   Are you a non-empty list ? (check nil? first)
# - nil?        Are you false, or an empty list ?
# - value       Return your value

package require TclOO

oo::class create ::mustache::context {

    # State
# - A Stack Of Frames
# - A Current Frame (Top Of Stack) - Term "dot".





    
    constructor {rootframe} {
	((TODO)) - templates for inclusion (partials)
	((TODO)) - partials parsed lazy, memoized
	
	my push $rootframe
	my __clear
	return
    }

    method __found {field frame} {
	set lastfield $field
	set lastframe $frame
    }
    method __clear {field frame} {
	my __found {} {}
    }
    
    method focus {field} {
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
	foreach frame [lreverse $frames] {
	    if {![{*}$frame has? $field]} continue
	    __found $field [{*}$frame field $field]
	    return 1
	}
	return 0
    }

    method iter {script} {}

    method iterable? {} { {*}$dot iterable? }
    method nil?      {} { {*}$dot nil?      }

    method pop {} {
	set frames [lreplace $frames end end]
	set dot    [lindex   $frames end]
	return
    }

    method push {frame} {
	lappend frames $frame
	set     dot    $frame
	return
    }
    
    method value {} { {*}$dot value }

    variable frames
    variable dot
    variable lastfield
    variable lastframe    
}
