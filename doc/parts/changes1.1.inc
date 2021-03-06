[subsection {Changes for version 1.1}]

[list_begin enumerated]
[comment {- - -- --- ----- -------- ------------- ---------------------}]

[enum] Extended the [package mustache::frame] package to support the
       [vset tclyaml/core] version 0.5 tags for [const bool],
       [const float], [const int], [const null], and [const string].

[para] The pre-existing tag [const scalar] is now a an alias for
       [const string].

[para] This extension of the type system makes it easier to use
       [vset PROJECT]'s data frames as an in-memory representation for
       structured typed data. No automatic loss of type data inside of
       Tcl scripts now.

[enum] Extended the data frames provided by package
       [package mustache::frame] with methods for walking a frame tree
       in general, and simplifying the conversion back into external
       serialization formats.

[enum] Extended the sequence and mapping data frames provided by
       package [package mustache::frame] with methods ([method for])
       for iteration over the content, without a context.

[enum] Added packages for the conversion of a data frame (tree) into
       various serializations:

[list_begin definitions]
[def [package mustache::frame::as::events]]

Serialization into a list of events describing the incremental build of the tree.

[def [package mustache::frame::as::json]]

Serialization into whitespace-free [vset json].

[def [package mustache::frame::as::tagged]]

Serialization into the kind of tagged structure accepted by
[vset tclyaml/core]'s [cmd writeTags] command.

[list_end]

[comment {- - -- --- ----- -------- ------------- ---------------------}]
[list_end]
