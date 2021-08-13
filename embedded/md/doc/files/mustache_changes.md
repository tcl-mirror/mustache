
[//000000001]: # (mustache\-changes \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_changes\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache\-changes\(n\) 1\.1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\-changes \- Mustache \- Log of Changes

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Description](#section1)

  - [Changes](#section2)

      - [Changes for version 1\.2](#subsection1)

      - [Changes for version 1\.1](#subsection2)

      - [Changes for version 1](#subsection3)

  - [Related Documents](#section3)

  - [Bugs, Ideas, Feedback](#section4)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

This document provides an overview of the changes
__[mustache](mustache\.md)__ underwent from version to version\.

# <a name='section2'></a>Changes

## <a name='subsection1'></a>Changes for version 1\.2

*Version 1\.2 is in development and has not been released yet*

  1. *Attention*

     Added a new __string\!__ type to the
     __[mustache::frame](mustache\_frame\.md)__ package\.

     It is strongly recommended to use this type for any kind of string value
     instead of old type __string__ \(without a trailing *\!*\.

     Why ?

     The original __string__ type is coded to match the expectations of the
     mustache specification, as laid down by its official compatibility
     testsuite\.

     This includes some very weird behaviour for a __string__ type: It
     "normalizes" any string which looks like a double number, which means
     anything which looks numeric\. That is a very bad thing to do when your
     strings are, for example file and directory names, just looking like
     numbers\. Then you call such normalization "mangling" instead and start
     cursing\.

     The new __string\!__ type does no such mangling\.

     The new type is now the standard type when converting to and from YAML, and
     other such representations\. I\.e\. an external string is mapped to
     __string\!__ now\.

     Existing code using __string__ directly in the construction of frames
     has to be manually converted to use __string\!__ however\.

  1. Extended the __[mustache::frame](mustache\_frame\.md)__ package with
     several methods specific to scalars and mappings, and one generic\.

     It is now possible to change a scalar's value in place, as well as add,
     remove, and move key/value assignments in a mapping\.

     The new generic method simplifies the writing of type checks\. Instead of

         [$frame type] eq "mapping"

     it is now possible to write

         [$frame is mapping]

     etc\.

## <a name='subsection2'></a>Changes for version 1\.1

  1. Extended the __[mustache::frame](mustache\_frame\.md)__ package to
     support the [TclYAML](https://core\.tcl\-lang\.org/akupries/tclyaml)
     version 0\.5 tags for __bool__, __float__, __int__,
     __null__, and __string__\.

     The pre\-existing tag __scalar__ is now a an alias for __string__\.

     This extension of the type system makes it easier to use mustache's data
     frames as an in\-memory representation for structured typed data\. No
     automatic loss of type data inside of Tcl scripts now\.

  1. Extended the data frames provided by package
     __[mustache::frame](mustache\_frame\.md)__ with methods for walking a
     frame tree in general, and simplifying the conversion back into external
     serialization formats\.

  1. Extended the sequence and mapping data frames provided by package
     __[mustache::frame](mustache\_frame\.md)__ with methods \(__for__\)
     for iteration over the content, without a context\.

  1. Added packages for the conversion of a data frame \(tree\) into various
     serializations:

       - __mustache::frame::as::events__

         Serialization into a list of events describing the incremental build of
         the tree\.

       - __mustache::frame::as::json__

         Serialization into whitespace\-free [JSON](https://json\.org/)\.

       - __mustache::frame::as::tagged__

         Serialization into the kind of tagged structure accepted by
         [TclYAML](https://core\.tcl\-lang\.org/akupries/tclyaml)'s
         __writeTags__ command\.

## <a name='subsection3'></a>Changes for version 1

This is the first release of mustache\. The changes therefore describe the
initial features of the system\.

In detail:

  1. mustache requires Tcl 8\.5 or higher\. Tcl 8\.4 or less is not supported\.

  1. mustache requires TclOO\.

  1. The project provides several high\- and low\-level packages for the parsing
     and rendering of logic\-less templates as specified by Ruby's
     __[mustache](mustache\.md)__ package\.

# <a name='section3'></a>Related Documents

  1. *[Mustache \- Introduction to the project](mustache\_introduction\.md)*

  1. *[Mustache \- License](mustache\_license\.md)*

  1. *Mustache \- Log of Changes*

  1. *[Mustache \- How To Get The Sources](mustache\_howto\_get\_sources\.md)*

  1. *[Mustache \- The Installer's Guide](mustache\_howto\_installation\.md)*

  1. *[Mustache \- The Developer's Guide](mustache\_howto\_development\.md)*

# <a name='section4'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[logic\-less templates](\.\./\.\./index\.md\#logic\_less\_templates),
[mustache](\.\./\.\./index\.md\#mustache),
[templating](\.\./\.\./index\.md\#templating)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries  
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
