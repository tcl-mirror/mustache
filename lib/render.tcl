## -*- tcl -*-
# # ## ### ##### ######## #############
## (c) 2019 Andreas Kupries

# @@ Meta Begin
# Package mustache::render 0
# Meta author      {Andreas Kupries}
# Meta category    Template Processing
# Meta description Implementation of mustache, rendering
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

package provide mustache::render 0

# # ## ### ##### ######## #############

namespace eval ::mustache {
    namespace export render
    namespace ensemble create
}
namespace eval ::mustache::R {
    namespace export all lit var var.dot var/escaped.dot dot \
	section isection partial
    namespace ensemble create
}

# # ## ### ##### ######## ############# #####################

debug define mustache/render
debug level  mustache/render
debug prefix mustache/render {[debug caller] | }

# # ## ### ##### ######## #############
## API

proc ::mustache::render {template context writer} {
    debug.mustache/render {}
    # template :: children
    # children :: list (node|leaf)
    # node :: list (node-cmd pos field children)
    # leaf :: list (leaf-cmd details...)
    ##
    # Each tree tag ((node|leaf)-cmd) is implemented as procedure in
    # the internal R namespace/ensemble.
    ##
    # [ok] dot			Leaf
    # [ok] isection
    # [..] isection.dot
    # [ok] lit			Leaf
    # [ok] partial
    # [ok] section
    # [..] section.dot
    # [ok] var			Leaf
    # [ok] var.dot		Leaf
    # [ok] var/escaped		Leaf
    # [ok] var/escaped.dot	Leaf

    R all $template $context $writer
    return
}

# # ## ### ##### ######## #############
## Internals

proc ::mustache::R::all {template context writer} {
    debug.mustache/render {}
    foreach node $template {
	{*}$node $context $writer
    }
    return
}

proc ::mustache::R::lit {text context writer} {
    debug.mustache/render {}
    D $writer $text
    return
}

proc ::mustache::R::var {field context writer} {
    debug.mustache/render {}
    # Ignore missing field
    if {![D $context has? $field]} return
    # Write field value, it is dot for but a moment.
    D $context focus $field
    D $writer [D $context value]
    D $context pop
    return
}

proc ::mustache::R::var.dot {field context writer} {
    debug.mustache/render {}
    # Ignore missing field
    if {![D $context has.dot? $field]} return
    # Write field value, it is dot for but a moment.
    D $context focus.dot $field
    D $writer [D $context value]
    D $context pop
    return
}

proc ::mustache::R::var/escaped {field context writer} {
    debug.mustache/render {}
    # Ignore missing field
    if {![D $context has? $field]} return
    # Write field value, it is dot for but a moment.
    D $context focus $field
    D $writer [HTMLEscape [D $context value]]
    D $context pop
    return
}

proc ::mustache::R::var/escaped.dot {field context writer} {
    debug.mustache/render {}
    # Ignore missing field
    if {![D $context has.dot? $field]} return
    # Write field value, it is dot for but a moment.
    D $context focus.dot $field
    D $writer [HTMLEscape [D $context value]]
    D $context pop
    return
}

proc ::mustache::R::dot {_ context writer} {
    debug.mustache/render {}
    D $writer [HTMLEscape [D $context value]]
    return
}

proc ::mustache::R::section {pos field children context writer} {
    debug.mustache/render {}
    # For a missing field skip the section.
    if {![D $context has? $field]} return

    # The field is the new context.
    D $context focus $field

    # section behaviour:
    # false? - skip                \ nil?
    # true? - list? - empty ? skip /
    #                 iterate list
    #         once

    # Skip section if dot is false, or empty list.
    if {[D $context nil?]} return

    # Iterate a non-empty list.
    if {[D $context iterable?]} {
	D $context iter {
	    all $children $context $writer
	}
	D $context pop
	return
    }

    # Not a list, not false either => Render once
    all $children $context $writer
    D $context pop
    return
}

proc ::mustache::R::isection {pos field children context writer} {
    debug.mustache/render {}
    # Render once if field missing, false, or empty list.
    if {[D $context has? $field]} {
	D $context focus $field
	if {![D $context nil?]} return
	D $context pop
    }

    all $children $context $writer
    return
}

proc ::mustache::R::partial {pos field context writer} {
    debug.mustache/render {}

    # field = symbolic name of template to insert and render here.
    if {![D $context template? $field]} return
    all [D $context template $field] $context $writer
    return
}

proc ::mustache::R::D {prefix args} {
    uplevel #0 [list {*}$prefix {*}$args]
}

proc ::mustache::R::HTMLEscape {text} {
    # Not exported, not structure tag
    debug.mustache/render {}
    string map {
	&    &amp;
	<    &lt;
	>    &gt;
	"\"" &quot;
        '    &#39;
    } $text
}

# # ## ### ##### ######## #############
return
