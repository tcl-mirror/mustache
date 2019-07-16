#!/bin/sh
# -*- tcl -*- \
exec kettle -f "$0" "${1+$@}"
# For kettle sources, documentation, etc. see
# - https://core.tcl-lang.org/akupries/kettle
# - http://chiselapp.com/user/andreas_kupries/repository/Kettle
kettle tclapp bin/mustache
kettle tcl
