## -*- tcl -*-
# # ## ### ##### ######## #############
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache 0
# Meta author      {Andreas Kupries}
# Meta category    Template Processing
# Meta description Implementation of mustache, user commands
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

package require mustache::parse
package require mustache::render

package provide mustache 0

# # ## ### ##### ######## #############

namespace eval ::mustache {
    namespace export mustache mustache/pt
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/mustache
debug level  mustache/mustache
debug prefix mustache/mustache {[debug caller] | }

# # ## ### ##### ######## #############
## API

proc ::mustache::mustache {template context} {
    debug.mustache/mustache {}

    variable result {}
    render \
	[parse $template] \
	$context \
	{::append ::mustache::result}
    set tmp $result
    unset result
    return $tmp
}

proc ::mustache::mustache/pt {parsed_template context} {
    debug.mustache/mustache {}

    variable result {}
    render \
	$parsed_template \
	$context \
	{::append ::mustache::result}
    set tmp $result
    unset result
    return $tmp
}

# # ## ### ##### ######## #############
return
