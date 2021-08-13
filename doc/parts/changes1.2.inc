[subsection {Changes for version 1.2}]

[strong {Version 1.2 is in development and has not been released yet}]

[list_begin enumerated]
[comment {- - -- --- ----- -------- ------------- ---------------------}]

[enum] [strong Attention]

[para] Added a new [type string!] type to the
       [package mustache::frame] package.

[para] It is strongly recommended to use this type for any kind of
       string value instead of old type [type string] (without a
       trailing [strong !].

[para] Why ?

[para] The original [type string] type is coded to match the
       expectations of the mustache specification, as laid down by its
       official compatibility testsuite.

[para] This includes some very weird behaviour for a [type string]
       type: It "normalizes" any string which looks like a double
       number, which means anything which looks numeric. That is a
       very bad thing to do when your strings are, for example file
       and directory names, just looking like numbers. Then you call
       such normalization "mangling" instead and start cursing.

[para] The new [type string!] type does no such mangling.

[para] The new type is now the standard type when converting to and
       from YAML, and other such representations. I.e. an external
       string is mapped to [type string!] now.

[para] Existing code using [type string] directly in the construction
       of frames has to be manually converted to use [type string!]
       however.

[enum] Extended the [package mustache::frame] package with several
       methods specific to scalars and mappings, and one generic.

[para] It is now possible to change a scalar's value in place, as well as
       add, remove, and move key/value assignments in a mapping.

[para] The new generic method simplifies the writing of type checks.
       Instead of

       [example {[$frame type] eq "mapping"}]

       it is now possible to write

       [example {[$frame is mapping]}]

       etc.

[comment {- - -- --- ----- -------- ------------- ---------------------}]
[list_end]
