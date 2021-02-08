
[//000000001]: # (mustache::context \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_context\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache::context\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache::context \- Mustache \- Field resolution context

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

package require mustache::context  

[__::mustache context__ __create__ *obj* *frame*](#1)  
[__::mustache context__ __new__ *frame*](#2)  
[__<contextcmd>__ __has?__ *field*](#3)  
[__<contextcmd>__ __focus__ *field*](#4)  
[__<contextcmd>__ __pop__](#5)  
[__<contextcmd>__ __push__ *frame*](#6)  
[__<contextcmd>__ __iterable?__](#7)  
[__<contextcmd>__ __nil?__](#8)  
[__<contextcmd>__ __[value](\.\./\.\./index\.md\#value)__](#9)  
[__<contextcmd>__ __iter__ *script*](#10)  
[__<contextcmd>__ __template?__ *name*](#11)  
[__<contextcmd>__ __template:__ *name* *specification*](#12)  
[__<contextcmd>__ __template__ *name*](#13)  

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

# <a name='section2'></a>Overview

The __mustache render__ command provided by package
__[mustache::render](mustache\_render\.md)__ requires a
*[context](\.\./\.\./index\.md\#context)* as the source of the values to
interpolate into the template it is invoked with\.

This package provides a suitable __TclOO__ class\.

Note however that *any* command prefix supporting the [Instance
API](#section4) below will be suitable\.

# <a name='section3'></a>Class API

  - <a name='1'></a>__::mustache context__ __create__ *obj* *frame*

    This constructor command creates a new instance *obj* of the class,
    initializes it using the data *frame* and returns the fully qualified name
    of that instance\.

    The *frame* command prefix has to support the API of
    __[mustache::frame](mustache\_frame\.md)__ objects\.

    *Attention:* The *frame* object becomes owned by the context, and will
    be destroyed when the context is destroyed\.

    Additional initialization, i\.e\. definition of *partials* \(aka *parts*,
    aka *includes*\) can be done via the __template:__ instance method\.

  - <a name='2'></a>__::mustache context__ __new__ *frame*

    This constructor command creates a new instance of the class, initializes it
    using the data *frame* and returns the fully qualified name of that
    instance\.

    The *frame* command prefix has to support the API of
    __[mustache::frame](mustache\_frame\.md)__ objects\.

    *Attention:* The *frame* object becomes owned by the context, and will
    be destroyed when the context is destroyed\.

    Additional initialization, i\.e\. definition of *partials* \(aka *parts*,
    aka *includes*\) can be done via the __template:__ instance method\.

# <a name='section4'></a>Instance API

Contexts are what the mustache renderer delegates field resolution to, and
retrieves the values to interpolate from\.

From its point of view a context is a stack of *data frames* from which it can
pull values\. The data frame at the top of the stack is called
*[dot](\.\./\.\./index\.md\#dot)*\. Any search for named fields starts at
*[dot](\.\./\.\./index\.md\#dot)*, moving deeper into the stack only on misses\.

During rendering data frames are pushed on and popped of the stack at the behest
of the renderer, as it walks the template structure\.

  - <a name='3'></a>__<contextcmd>__ __has?__ *field*

    Searches the context for the named *field*\. Returns a boolean value
    indicating either success \(__true__\) or failure \(__false__\) of the
    search\.

  - <a name='4'></a>__<contextcmd>__ __focus__ *field*

    Searches the context for the named *field*\. Throws an error when the field
    is not found\. When found the data frame associated with the field is pushed
    on the search stack, i\.e\. made *[dot](\.\./\.\./index\.md\#dot)*\.

    Returns the empty string\.

  - <a name='5'></a>__<contextcmd>__ __pop__

    Removes the data frame at the top of the search stack\. Throws an error when
    trying to pop the root data frame\. That is the *frame* supplied during
    construction of the context\.

    Returns the empty string\.

  - <a name='6'></a>__<contextcmd>__ __push__ *frame*

    Pushed the *frame* on top of the search stack\.

    The *frame* command prefix has to support the API of
    __[mustache::frame](mustache\_frame\.md)__ objects\.

    Returns the empty string\.

  - <a name='7'></a>__<contextcmd>__ __iterable?__

    Asks *[dot](\.\./\.\./index\.md\#dot)* if it can be iterated over\. In other
    words, if it is a non\-empty sequence of values\.

    Returns a boolean value\. __true__ signals that
    *[dot](\.\./\.\./index\.md\#dot)* can be iterated over\.

  - <a name='8'></a>__<contextcmd>__ __nil?__

    Asks *[dot](\.\./\.\./index\.md\#dot)* if it is nil, false, empty, etc\.

    Returns a boolean value\. __true__ signals that
    *[dot](\.\./\.\./index\.md\#dot)* is indeed nil, empty, false, etc\.

  - <a name='9'></a>__<contextcmd>__ __[value](\.\./\.\./index\.md\#value)__

    Asks *[dot](\.\./\.\./index\.md\#dot)* for its value, and returns it\.

  - <a name='10'></a>__<contextcmd>__ __iter__ *script*

    Iterates over the elements of *[dot](\.\./\.\./index\.md\#dot)* and invokes
    the *script* for each element\. During the execution of the *script* the
    active element will be *[dot](\.\./\.\./index\.md\#dot)*\.

    Returns the empty string\.

  - <a name='11'></a>__<contextcmd>__ __template?__ *name*

    Checks if the context knows abut the *name*d template\. Returns a boolean
    value indicating either success \(__true__\) or failure \(__false__\) of
    the search\.

  - <a name='12'></a>__<contextcmd>__ __template:__ *name* *specification*

    Defines a new template with *name* and *specification*\.

    Returns the empty string\.

  - <a name='13'></a>__<contextcmd>__ __template__ *name*

    Returns the specification of the *name*d template\. Throws an error when a
    template of the *name* is not known\.

# <a name='section5'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[context](\.\./\.\./index\.md\#context), [contexts](\.\./\.\./index\.md\#contexts),
[dot](\.\./\.\./index\.md\#dot), [logic\-less
templates](\.\./\.\./index\.md\#logic\_less\_templates),
[mustache](\.\./\.\./index\.md\#mustache),
[templating](\.\./\.\./index\.md\#templating)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries  
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
