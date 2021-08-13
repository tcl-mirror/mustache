
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

  - [Scalar Instance API](#section5)

  - [Mapping Instance API](#section6)

  - [Bugs, Ideas, Feedback](#section7)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='synopsis'></a>SYNOPSIS

package require mustache::frame  

[__::mustache frame fromTags__ *spec*](#1)  
[__::mustache frame bool__ __create__ *obj* *value*](#2)  
[__::mustache frame bool__ __new__ *value*](#3)  
[__::mustache frame float__ __create__ *obj* *value*](#4)  
[__::mustache frame float__ __new__ *value*](#5)  
[__::mustache frame int__ __create__ *obj* *value*](#6)  
[__::mustache frame int__ __new__ *value*](#7)  
[__::mustache frame null__ __create__ *obj* ?*value*?](#8)  
[__::mustache frame null__ __new__ ?*value*?](#9)  
[__::mustache frame scalar__ __create__ *obj* *value*](#10)  
[__::mustache frame scalar__ __new__ *value*](#11)  
[__::mustache frame string__ __create__ *obj* *value*](#12)  
[__::mustache frame string__ __new__ *value*](#13)  
[__::mustache frame string\!__ __create__ *obj* *value*](#14)  
[__::mustache frame string\!__ __new__ *value*](#15)  
[__::mustache frame sequence__ __create__ *obj* *value*](#16)  
[__::mustache frame sequence__ __new__ *value*](#17)  
[__::mustache frame mapping__ __create__ *obj* *value*](#18)  
[__::mustache frame mapping__ __new__ *value*](#19)  
[__frameCmd__ __type__](#20)  
[__frameCmd__ __is__ *type*](#21)  
[__frameCmd__ __has?__ *field*](#22)  
[__frameCmd__ __field__ *field*](#23)  
[__frameCmd__ __iter__ *context* *script*](#24)  
[__frameCmd__ __iterable?__](#25)  
[__frameCmd__ __nil?__](#26)  
[__frameCmd__ __[value](\.\./\.\./index\.md\#value)__](#27)  
[__frameCmd__ __as__ *type*](#28)  
[__frameCmd__ __visit__ ?*word*\.\.\.?](#29)  
[__\{\*\}word\.\.\.__ *type* *frame* *value*](#30)  
[__\{\*\}word\.\.\.__ __sequence start__ *frame*](#31)  
[__\{\*\}word\.\.\.__ __sequence exit__ *frame* *value*](#32)  
[__\{\*\}word\.\.\.__ __mapping start__ *frame*](#33)  
[__\{\*\}word\.\.\.__ __mapping exit__ *frame* *value*](#34)  
[__scalarCmd__ __set__ *value*](#35)  
[__scalarCmd__ __validate__ *value*](#36)  
[__mappingCmd__ __set__ *key* *value*](#37)  
[__mappingCmd__ __unset__ *key*](#38)  
[__mappingCmd__ __rename__ *key* *newkey*](#39)  

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

__mustache::frame__ provides seven TclOO classes for holding scalar values
of various types, sequences, and mappings, all suitable for working with the
objects provided by the __[mustache::context](mustache\_context\.md)__
package\.

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

      * __bool__

        The value is a boolean\.

      * __float__

        The value is a floating point number\.

      * __int__

        The value is an integer number\.

      * __null__

        The value is null/nil/missing\.

      * __scalar__

      * __string__

        The value is an arbitrary string\. Internally it is mapped to
        __string\!__ frames\.

      * __sequence__

        The value is a Tcl list containing nested specs\.

      * __mapping__

        The value is a Tcl dictionary whose keys and values are nested specs\.
        Note however that it is expected that keys are always tagged as scalars\.

    *Note* that the
    __[TclYAML](https://core\.tcl\-lang\.org/akupries/tclyaml)__ package is
    able to generate this type of tagged structure\.

    *Note* further that the type\-specific tags are only generated by
    [TclYAML](https://core\.tcl\-lang\.org/akupries/tclyaml) version 0\.5 and
    up\. Version 0\.4 and before generate only the un\-typed __scalar__ tag\.

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

  - <a name='2'></a>__::mustache frame bool__ __create__ *obj* *value*

  - <a name='3'></a>__::mustache frame bool__ __new__ *value*

  - <a name='4'></a>__::mustache frame float__ __create__ *obj* *value*

  - <a name='5'></a>__::mustache frame float__ __new__ *value*

  - <a name='6'></a>__::mustache frame int__ __create__ *obj* *value*

  - <a name='7'></a>__::mustache frame int__ __new__ *value*

  - <a name='8'></a>__::mustache frame null__ __create__ *obj* ?*value*?

  - <a name='9'></a>__::mustache frame null__ __new__ ?*value*?

  - <a name='10'></a>__::mustache frame scalar__ __create__ *obj* *value*

  - <a name='11'></a>__::mustache frame scalar__ __new__ *value*

  - <a name='12'></a>__::mustache frame string__ __create__ *obj* *value*

  - <a name='13'></a>__::mustache frame string__ __new__ *value*

  - <a name='14'></a>__::mustache frame string\!__ __create__ *obj* *value*

  - <a name='15'></a>__::mustache frame string\!__ __new__ *value*

    These constructor commands create a new *scalar* data frame of the given
    type, initialize it using the *value* and return the fully qualified name
    of that instance\.

    *ATTENTION* Of these three, best use __string\!__ over all else\.

    *Do not use* __string__\. While the disrecommended type is the original
    type for string values it is now present only to pass the mustache
    compatibility tests\. It comes with auto\-magic behaviour counter to what is
    expected from a string type, i\.e\. to pass all values as they are\.

    __string__ does not do that\. Any value which looks like a number it
    "normalizes"\.

    The new type __string\!__ on the other hand does exactly that\. No
    auto\-magic normalization, i\.e\. mangling of things looking like numbers\. Just
    passing values as they are\.

  - <a name='16'></a>__::mustache frame sequence__ __create__ *obj* *value*

  - <a name='17'></a>__::mustache frame sequence__ __new__ *value*

    These constructor commands create a new *sequence* data frame, initialize
    it using the *value* and return the fully qualified name of that instance\.

    The *value* has to be a list of data frame objects\.

    *Attention:* The new sequence takes over ownership of the data frames in
    the list, and they will be destroyed when the sequence is destroyed\.

  - <a name='18'></a>__::mustache frame mapping__ __create__ *obj* *value*

  - <a name='19'></a>__::mustache frame mapping__ __new__ *value*

    These constructor commands create a new *mapping* data frame, initialize
    it using the *value* and return the fully qualified name of that instance\.

    The *value* has to be a dictionary mapping arbitrary strings to data
    frames\. The keys of the dictionary name the fields which can be found in the
    mapping later on, and the data frames hold the associated values\.

    *Attention:* The new mapping takes over ownership of the data frames in
    the dictionary, and they will be destroyed when the mapping is destroyed\.

# <a name='section4'></a>Instance API

Data frames are what the context uses as containers for typed values\. It should
be noted that it actually does not care about the specific type of a value, only
about the behaviour it supports, which can be queried \(See the methods
__nil?__ and __iterable?__\)\.

  - <a name='20'></a>__frameCmd__ __type__

    Returns the type of the frame\.

  - <a name='21'></a>__frameCmd__ __is__ *type*

    Checks if the frame is of the specified *type* and returns the result as a
    boolean value\.

  - <a name='22'></a>__frameCmd__ __has?__ *field*

    Checks if the value has the named *field*\.

    Returns a boolean value indicating either success \(__true__\) or failure
    \(__false__\) of the search\.

    Note that scalars and sequences do not have fields\. Searching them always
    fails\.

  - <a name='23'></a>__frameCmd__ __field__ *field*

    Returns the data frame for the named *field*\.

    Scalars and sequences throw an error, as they do not have fields\. A mapping
    will throw an error only if the named *field* is not known\.

  - <a name='24'></a>__frameCmd__ __iter__ *context* *script*

    Iterates over the elements of the frame and invokes the *script* for each
    of them\. During the execution of the *script* the active element will be
    pushed into the *context*, and popped again after\.

    Returns the empty string\.

    Scalars and mappings will throw an error, as they cannot be iterated over\.

  - <a name='25'></a>__frameCmd__ __iterable?__

    Asks the frame if it can be iterated over\. In other words, if it is a
    non\-empty sequence of values\.

    Returns a boolean value\. __true__ signals that the frame can be iterated
    over\.

    Scalars and mappings always return __false__\. Sequences return
    __false__ only if they are mpty\.

  - <a name='26'></a>__frameCmd__ __nil?__

    Asks the frame if it is nil, false, empty, etc\.

    Returns a boolean value\. __true__ signals that the frame's value is
    indeed nil, empty, false, etc\.

    Strings are nil if they are either the empty string, or their value can be
    interpreted as a boolean value, and is representing __false__\.

    Numbers are never nil, nulls are always nil, and booleans are nil if they
    represent __false__\.

    Sequences and mappings are nil if they are empty, i\.e of length or size
    __0__\.

  - <a name='27'></a>__frameCmd__ __[value](\.\./\.\./index\.md\#value)__

    Returns the Tcl string value of the frame\. Supported by all types\.

    Sequences and mappings return Tcl stringifications of their list or
    dictionary, respectively\. This will recurse through nested structures\.

  - <a name='28'></a>__frameCmd__ __as__ *type*

    Returns the string representation of the data frame as per the specified
    *type*\.

    It is expected that the *type* is backed by a package named
    __::mustache::frame::as::<*type*>__, exporting a command of the same
    name\.

    This command has to be suitable for use with the data frame's __visit__
    method\. The __as__ method will invoke __visit__ with the type
    command to perform the actual conversion\.

  - <a name='29'></a>__frameCmd__ __visit__ ?*word*\.\.\.?

    This method visits the data frame and its children in interleaved pre\- and
    post\-order, invoking the command prefix specified by the *word*\.\.\. for
    each frame once \(scalars\) or twice \(sequences, and mappings\)\.

    The result of the method is the result of the last invokation of the command
    prefix for the top data frame\.

    The command prefix is always called in the global scope\. It is expected to
    support the signatures below\. The *frame* argument is always the object
    command of the data frame the call is for\.

      * <a name='30'></a>__\{\*\}word\.\.\.__ *type* *frame* *value*

        Called for all scalar frames, once\. The *value* is the Tcl value of
        the scalar\. The *type* is one of the possible scalar type tags\.

      * <a name='31'></a>__\{\*\}word\.\.\.__ __sequence start__ *frame*

        Called at the beginning of a sequence, enables initializations in the
        converter\. The return value, if any, is ignored\.

      * <a name='32'></a>__\{\*\}word\.\.\.__ __sequence exit__ *frame* *value*

        Called after visiting the children of a sequence\. The *value* is a
        list containing the results of visiting the sequence's elements\.

      * <a name='33'></a>__\{\*\}word\.\.\.__ __mapping start__ *frame*

        Called at the beginning of a mapping, enables initializations in the
        converter\. The return value, if any, is ignored\.

      * <a name='34'></a>__\{\*\}word\.\.\.__ __mapping exit__ *frame* *value*

        Called after visiting the value children of a mapping\. The *value* is
        a dictionary mapping the field names to the results of visiting their
        frames\.

# <a name='section5'></a>Scalar Instance API

Scalar data frames provide more than just the generic API\. These additional
methods should only be used after a type check:

  - <a name='35'></a>__scalarCmd__ __set__ *value*

    Set the new scalar *value* into the frame\. An error will be thrown if the
    value does not match the type of the frame\. The command returns the empty
    string\.

  - <a name='36'></a>__scalarCmd__ __validate__ *value*

    Validates the scalar *value* against the frame\. An error will be thrown if
    the value does not match the type of the frame\. The command returns the
    normalized value, as per the frame's type\.

# <a name='section6'></a>Mapping Instance API

Mapping data frames provide more than just the generic API\. These additional
methods should only be used after a type check:

  - <a name='37'></a>__mappingCmd__ __set__ *key* *value*

    Extends or modifies the mapping\. After the call the *key* maps to the
    *value* frame\. A previously existing assignment for the *key* is
    destroyed\. The command returns the empty string\.

  - <a name='38'></a>__mappingCmd__ __unset__ *key*

    Removes the assignment identified by *key* from the mapping\. The
    associated value frame is destroyed\. The command returns the empty string\.

  - <a name='39'></a>__mappingCmd__ __rename__ *key* *newkey*

    Move the assignment of *key* to the *newky*\. An error will be thrown if
    the *key* does not exist\. A previously existing assignment for the
    *newkey* is destroyed\. The command returns the empty string\.

# <a name='section7'></a>Bugs, Ideas, Feedback

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
