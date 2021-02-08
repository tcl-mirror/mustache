
[//000000001]: # (mustache::parse \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_parse\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache::parse\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache::parse \- Mustache \- Parsing templates

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

package require mustache::parse  

[__::mustache__ __parse__ *template* ?*delimiters*?](#1)  

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

# <a name='section2'></a>Overview

The __mustache::parse__ package provides the parser for
[mustache](https://mustache\.github\.io/) templates\.

# <a name='section3'></a>Commands

  - <a name='1'></a>__::mustache__ __parse__ *template* ?*delimiters*?

    This command parses the [mustache](https://mustache\.github\.io/)
    *template*, and returns a Tcl data structure representing it\.

    The details of the data structure are *not documented* by design, they are
    not relevant to users of the command\.

    All it is necessary to know is that the __mustache render__ command
    provided by the __[mustache::render](mustache\_render\.md)__ package
    takes such a structure and renders it, using a
    *[context](\.\./\.\./index\.md\#context)* as the source of the data to
    interpolate\.

    By default the parser will use the strings __\{\{__ and __\}\}__ to
    detect beginning and end of mustache tags\. This can be overridden using the
    *delimiters* argument\. It is expected to be a 2\-element list of tag opener
    and closer strings, in this order\. *Note* however that the same effect can
    be achieved by prefixing the *template* string with the proper mustache
    tag for changing the delimiters\. As an example, the tag __\{\{=<< >>=\}\}__
    will change the delimiters to __<<__ and __>>__\.

# <a name='section4'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[logic\-less templates](\.\./\.\./index\.md\#logic\_less\_templates),
[mustache](\.\./\.\./index\.md\#mustache), [parser](\.\./\.\./index\.md\#parser),
[templating](\.\./\.\./index\.md\#templating)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries  
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
