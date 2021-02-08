
[//000000001]: # (mustache \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000004]: # (mustache\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> | <a
href="../../toc.md">Main Table Of Contents</a> | <a
href="../toc.md">Table Of Contents</a> | <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache \- Mustache \- Main package

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Synopsis](#synopsis)

  - [Description](#section1)

  - [Overview](#section2)

  - [Commands](#section3)

  - [Bugs, Ideas, Feedback](#section4)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='synopsis'></a>SYNOPSIS

package require mustache

[__::mustache__ __mustache__ *template* *context*](#1)
[__::mustache__ __mustache/pt__ *template* *context*](#2)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

# <a name='section2'></a>Overview

The __mustache__ package is the highest\-level package provided by the
project\. It provides a number of convenience commands encapsulating two common
usecases\.

For any not\-so common case it is necessary to directly use the lower\-level
packages, i\.e\. __[mustache::parse](mustache\_parse\.md)__, and
__[mustache::render](mustache\_render\.md)__\.

# <a name='section3'></a>Commands

The exported commands are:

  - <a name='1'></a>__::mustache__ __mustache__ *template* *context*

    This command parses the [mustache](https://mustache\.github\.io/)
    *template*, renders it using the *context* as the source of the data to
    interpolate, and returns the result\.

    The command throws errors when the template cannot be parsed\.

    The command expects *context* to be command prefix supporting the API of
    __[mustache::context](mustache\_context\.md)__ objects\.

  - <a name='2'></a>__::mustache__ __mustache/pt__ *template* *context*

    This command renders the pre\-parsed *template* using the *context* as
    the source of the data to interpolate, and returns the result\.

    This is useful if the same template has to be applied to many different
    contexts, as the template will be parsed only once\. Which the caller is
    responsible for, using the __[mustache::parse](mustache\_parse\.md)__
    package\.

    The command expects *context* to be command prefix supporting the API of
    __[mustache::context](mustache\_context\.md)__ objects\.

# <a name='section4'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[logic\-less templates](\.\./\.\./index\.md\#key0),
[mustache](\.\./\.\./index\.md\#key2), [templating](\.\./\.\./index\.md\#key1)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
