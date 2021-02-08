
[//000000001]: # (mustache\-app \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_application\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache\-app\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\-app \- Mustache \- Application

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Synopsis](#synopsis)

  - [Description](#section1)

  - [Overview](#section2)

  - [Syntax](#section3)

  - [Bugs, Ideas, Feedback](#section4)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='synopsis'></a>SYNOPSIS

package require mustache

[__[mustache](mustache\.md)__ *datafile* *templatefile*](#1)
[__[mustache](mustache\.md)__ *templatefile*](#2)
[__[mustache](mustache\.md)__](#3)
[__[mustache](mustache\.md)__ __\-t__&#124;__\-\-token__ *templatefile*](#4)
[__[mustache](mustache\.md)__ __\-h__&#124;__\-\-help__](#5)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

# <a name='section2'></a>Overview

__[mustache](mustache\.md)__ is a simple command\-line application
providing easy access to the functionality of the project\. Taking
[yaml](https://yaml\.org/)\-formatted data \(as file, or from stdin\) and a
mustache template \(from file or stdin\) it prints the result of rendering the
template against all the data\.

# <a name='section3'></a>Syntax

  - <a name='1'></a>__[mustache](mustache\.md)__ *datafile* *templatefile*

    Renders the [yaml](https://yaml\.org/) data in the *datafile* against
    the mustache template in *templatefile* and prints the result to its
    standard output\.

    Note that the data file may contain more than one
    [yaml](https://yaml\.org/) document, separated by __\-\-\-__\. In that
    case each document is separately rendered and printed\. Note that the
    application will not insert separators into such an output\. Desired or
    required separators have to be part of the template\.

  - <a name='2'></a>__[mustache](mustache\.md)__ *templatefile*

    As above, however the [yaml](https://yaml\.org/) documents are read from
    the standard input of the application\.

  - <a name='3'></a>__[mustache](mustache\.md)__

    As above, however both the [yaml](https://yaml\.org/) documents and the
    template are read from the standard input of the application\. The template
    is the block of text found after the last __\-\-\-__ separator\.

  - <a name='4'></a>__[mustache](mustache\.md)__ __\-t__&#124;__\-\-token__ *templatefile*

    Parses the template stored in the *templatefile* and prints the extracted
    structure to the standard output of the application for inspection\.

  - <a name='5'></a>__[mustache](mustache\.md)__ __\-h__&#124;__\-\-help__

    Prints basic usage information \(command syntax\) to the standard output of
    the application\.

# <a name='section4'></a>Bugs, Ideas, Feedback

Both the package\(s\) and this documentation will undoubtedly contain bugs and
other problems\. Please report such at [Mustache
Tracker](https://core\.tcl\-lang\.org/akupries/mustache)\.

Please also report any ideas you may have for enhancements of either package\(s\)
and/or documentation\.

# <a name='keywords'></a>KEYWORDS

[application](\.\./\.\./index\.md\#application), [command
line](\.\./\.\./index\.md\#command\_line), [logic\-less
templates](\.\./\.\./index\.md\#logic\_less\_templates),
[mustache](\.\./\.\./index\.md\#mustache), [standard
input](\.\./\.\./index\.md\#standard\_input), [standard
output](\.\./\.\./index\.md\#standard\_output),
[templating](\.\./\.\./index\.md\#templating),
[terminal](\.\./\.\./index\.md\#terminal)

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2019\-2021 Andreas Kupries
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries
