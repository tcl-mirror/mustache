# -*- tcl -*-
## (c) 2019 Andreas Kupries
# # ## ### ##### ######## ############# #####################
## Utility functions for the tests.

# The original tests are declared via yaml files. Each testcase is
# declared with name, description, template to apply, input data to
# apply the template to, optional partials (included templates), and,
# of course, the expected result of the render.

package require tclyaml
package require fileutil

# # ## ### ##### ######## ############# #####################

proc td {} { tcltest::testsDirectory }

proc v {label args} { V $label $args }

proc V {label map} {
    set path [P $label]
    if {[file exists $path]} {
	return [M $map [tcltest::viewFile $path]]
    } else {
	return {}
    }
}
proc M  {map x}  { string map $map $x }
proc M' {x args} { string map $args $x }
proc P  {label}  { return [td]/results/${label} }

proc F {tree} { string trimright [F' {} $tree] \n }
proc F' {indent tree} {
    set r ""
    foreach el $tree {
	lassign $el cmd pos detail children
	if {$cmd in {section isection}} {
	    append r $indent "- " $cmd " " '$detail' \n
	    append r [F' "$indent  " $children]
	} elseif {$cmd eq "lit"} {
	    # detail is in pos, no pos information for literals
	    append r $indent "- " $cmd " " '[X $pos]' \n
	} else {
	    append r $indent "- " $cmd " " $pos " " '$detail' \n
	}
    }
    return $r
}
proc X {x} { string map  [list \n \\n \r \\r { } \\s \t \\t] $x }


proc Specs {} {
    lsort -dict [glob -directory [td]/inputs/spec *.yml]
}

proc Tests {specfile} {
    set spec  [lindex [tclyaml readTags file $specfile] 0 0]
    set tests [lindex [dict get [lindex $spec end] {scalar tests}] end]

    lappend r [string trim [file rootname [file tail $specfile]] {./~}]
    lappend r $tests
    return $r
}

proc Frame {spec args} {
    lappend args partials
    foreach v $args { upvar 1 $v $v }
    Decode $spec {*}$args

    # Convert the supplied data into a frame ...
    set data [mustache frame fromTags [list mapping $data]]
    # ... and wrap it into a template context
    set data [mustache context new $data]

    if {![info exists partials]} return

    # Extend the context with partials, if any.
    set partials [lindex $partials end]
    foreach {partname partval} $partials {
	set partname [lindex $partname end]
	set partval  [lindex $partval  end]
	$data template: $partname $partval
    }
    return
}

proc Decode {spec args} {
    foreach v $args { upvar 1 $v _$v }
    foreach {k v} [lindex $spec end] {
	set k [lindex $k end]
	set _$k [lindex $v end]
    }
    set _name [dName $_name]
    return
}

proc dName {name} {
    return [string map {
	.-. .
	(   {}
	)   {}
    } [string tolower [join $name .]]]
}

# # ## ### ##### ######## ############# #####################
return
