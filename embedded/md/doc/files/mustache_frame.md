
[//000000001]: # (mustache::frame \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_frame\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache::frame\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache::frame \- Mustache \- Data frames with fields

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Synopsis](#synopsis)

  - [Description](#section1)

  - [Overview](#section2)

  - [Class API](#section3)

  - [Instance API](#section4)

  - [Bugs, Ideas, Feedback](#section5)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='synopsis'></a>SYNOPSIS

package require mustache::frame

[__::mustache frame fromTags__ *spec*](#1)
[__::mustache frame scalar__ __create__ *obj* *value*](#2)
[__::mustache frame scalar__ __new__ *value*](#3)
[__::mustache frame sequence__ __create__ *obj* *value*](#4)
[__::mustache frame sequence__ __new__ *value*](#5)
[__::mustache frame mapping__ __create__ *obj* *value*](#6)
[__::mustache frame mapping__ __new__ *value*](#7)
[__<framecmd>__ __has?__ *field*](#8)
[__<framecmd>__ __field__ *field*](#9)
[__<framecmd>__ __iter__ *context* *script*](#10)
[__<framecmd>__ __iterable?__](#11)
[__<framecmd>__ __nil?__](#12)
[__<framecmd>__ __[value](\.\./\.\./index\.md\#value)__](#13)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

# <a name='section2'></a>Overview

__[mustache::context](mustache\_context\.md)__ objects make use of
*[data frame](\.\./\.\./index\.md\#data\_frame)* objects to hold the values they
will hand to the __mustache render__ command while it renders a template\.

__mustache::frame__ provides three TclOO classes for holding scalar values,
sequences, and mappings, all suitable for working with the objects provided by
the __[mustache::context](mustache\_context\.md)__ package\.

Note however that *any* command prefix supporting the [Instance
API](#section4) below will be suitable for working with the same\.

This is not necessarily true for custom context objects\. Such may have their own
API for working with typed values\.

# <a name='section3'></a>Class API

  - <a name='1'></a>__::mustache frame fromTags__ *spec*

    Converts the tagged nested data structure in *spec*, representing a
    hierarchy of mappings, sequences, and scalar values, into an equivalent
    hierarchy of data frame objects\.

    Returns the root object of the generated data frame hierarchy\.

    The *spec* has to be a 2\-element list of tag and value, in this order\. The
    accepted tags and the associated values are

      * __scalar__

        The value is an arbitrary string\.

      * __sequence__

        The value is a Tcl list containing nested specs\.

      * __mapping__

        The value is a Tcl dictionary whose keys and values are nested specs\.
        Note however that it is expected that keys are always tagged as scalars\.

    Note that the __TclYAML__ package is able to generate this type of
    tagged structure\.

    Example:

        mapping {
        	{scalar FIELD} {scalar VAL}
        	{scalar SEQ} {sequence {
        		{scalar 1}
        		{scalar 2}
        		{scalar 3}
        	}}
        	{scalar SUB} {mapping {
        		{scalar CHILD} {scalar X}
        	}}
        }

  - <a name='2'></a>__::mustache frame scalar__ __create__ *obj* *value*

  - <a name='3'></a>__::mustache frame scalar__ __new__ *value*

    These constructor commands create a new scalar data frame, initializes it
    using the *value* and returns the fully qualified name of that instance\.

  - <a name='4'></a>__::mustache frame sequence__ __create__ *obj* *value*

  - <a name='5'></a>__::mustache frame sequence__ __new__ *value*

    These constructor commands create a new sequence data frame, initialize it
    using the *value* and return the fully qualified name of that instance\.

    The *value* has to be a list of data frames\.

    *Attention:* The new sequence takes over ownership of the data frames in
    the list, and they will be destroyed when the sequence is destroyed\.

  - <a name='6'></a>__::mustache frame mapping__ __create__ *obj* *value*

  - <a name='7'></a>__::mustache frame mapping__ __new__ *value*

    These constructor commands create a new mapping data frame, initialize it
    using the *value* and return the fully qualified name of that instance\.

    The *value* has to be a dictionary mapping arbitrary strings to data
    frames\. The keys name the fields which can be found, the data frames hold
    the associated values\.

    *Attention:* The new mapping takes over ownership of the data frames in
    the dictionary, and they will be destroyed when the mapping is destroyed\.

# <a name='section4'></a>Instance API

Data frames are what the context uses as containers for typed values\. It should
be noted that it actually does not care about the specific type of a value, only
about the behaviour it supports, which can be queried \(See methods __nil?__
and __iterable?__\)\.

  - <a name='8'></a>__<framecmd>__ __has?__ *field*

    Checks if the value has the named *field*\.

    Returns a boolean value indicating either success \(__true__\) or failure
    \(__false__\) of the search\.

    Note that scalars and sequences do not have fields, searching them always
    fails\.

  - <a name='9'></a>__<framecmd>__ __field__ *field*

    Returns the data frame for the named *field*\.

    Scalars and sequences throw an error, as they do not have fields\. A mapping
    will throw an error only if the named *field* is not known\.

  - <a name='10'></a>__<framecmd>__ __iter__ *context* *script*

    Interates over the elements of the frame and invokes the *script* for each
    of them\. During the execution of the *script* the active element will be
    pushed into the *context*, and popped again after\.

    Returns the empty string\.

    Scalars and mappings will throw an error, as they cannot be itereated over\.

  - <a name='11'></a>__<framecmd>__ __iterable?__

    Asks the frame if it can be iterated over\. In other words, if it is a
    non\-empty sequence of values\.

    Returns a boolean value\. __true__ signals that the frame can be iterated
    over\.

    Scalars and mapping always return __false__\. Sequences return
    __false__ only if they are mpty\.

  - <a name='12'></a>__<framecmd>__ __nil?__

    Asks the frame if it is nil, false, empty, etc\.

    Returns a boolean value\. __true__ signals that the frame's value is
    indeed nil, empty, false, etc\.

    Scalars are nil if they are either empty string, or represent a boolean
    __false__\.

    Sequences and mapping are nil if they are empty, i\.e of length or size
    __0__\.

  - <a name='13'></a>__<framecmd>__ __[value](\.\./\.\./index\.md\#value)__

    Returns the value of the frame\. Supported by all types\.

    Sequences and mappings return stringifications of their list or dictionary,
    respectively\. This will recurse through nested structures\.

# <a name='section5'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[data frame](\.\./\.\./index\.md\#data\_frame), [logic\-less
templates](\.\./\.\./index\.md\#logic\_less\_templates),
[mustache](\.\./\.\./index\.md\#mustache),
[templating](\.\./\.\./index\.md\#templating), [typed
value](\.\./\.\./index\.md\#typed\_value), [value](\.\./\.\./index\.md\#value)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
