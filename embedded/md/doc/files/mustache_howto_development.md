
[//000000001]: # (mustache\_development \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_howto\_development\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries
Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000004]: # (mustache\_development\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> | <a
href="../../toc.md">Main Table Of Contents</a> | <a
href="../toc.md">Table Of Contents</a> | <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\_development \- Mustache \- The Developer's Guide

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Description](#section1)

  - [Development Tools](#section2)

  - [Demonstration/Example Applications](#section3)

  - [Directory structure](#section4)

  - [Extended Build Actions](#section5)

  - [Architecture & Concepts](#section6)

  - [Related Documents](#section7)

  - [Bugs, Ideas, Feedback](#section8)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

The audience of this document are anyone wishing to modify Mustache in any way,
shape, or form\. This can be a maintainer fixing bugs, a developer adding
functionality, or patching it to accommodate local circumstances, etc\.

Please read

  1. *[Mustache \- How To Get The Sources](mustache\_howto\_get\_sources\.md)*
     and

  1. *[Mustache \- The Installer's Guide](mustache\_howto\_installation\.md)*

first, if that was not done already\. Here we assume that the sources are already
available in a directory of your choice, that it is known how to build and
install the project, and that all the necessary requisites are available\.

# <a name='section2'></a>Development Tools

Mustache requires the following tools going beyond those needed for build and
installation\.

  - __dia__

    Processor for __diagram__\-based figures\. See package __tklib__\.

  - __dtplite__

    Processor for __doctools__\-based documentation files, i\.e\. the "\.man"
    files under "doc/"\. See package __tcllib__\.

    This requirement is optional\. If a __Tcllib__ providing the package
    __dtplite__ is installed then __kettle__ will use the package in
    favor of the external application\.

# <a name='section3'></a>Demonstration/Example Applications

Mustache \(currently\) does not have demonstrations, nor examples\.

# <a name='section4'></a>Directory structure

The directory structure of the sources is as explained below:

  - "build\.tcl"

    The main file of the __kettle__\-based build\-system\.

  - "doc/"

    Main directory for all documentation\.

    Based on the __doctools__ package and tools provided by __Tcllib__\.

  - "doc/figures/"

    Main directory for all diagrams and figures used by the documentation\.

    Based on the __diagram__ package and tools provided by __Tklib__\.

  - "embedded/"

    Compiled documentation \(manpages and markdown\)\. Part of the repository for

      1. easy access from the repository's web interface \([embedded
         documentation](http://fossil\-scm\.org/index\.html/doc/tip/www/embeddeddoc\.wiki)\),
         and

      1. quicker installation \(no need to compile during the installation
         process itself\)\.

  - "tests/"

    Main directory for the test\-suite\.

    Based on the __tcltest__ package distributed with the Tcl core\.

  - "lib/"

    Main directory for the provided packages\.

  - "bin/"

    Main directory for the provided applications\.

    Based on the __tcltest__ package distributed with the Tcl core\.

  - "lib/mustache\.tcl"

    Package __[mustache](mustache\.md)__\.

  - "lib/context\.tcl"

    Package __[mustache::context](mustache\_context\.md)__\.

  - "lib/frame\.tcl"

    Package __[mustache::frame](mustache\_frame\.md)__\.

  - "lib/parse\.tcl"

    Package __[mustache::parse](mustache\_parse\.md)__\.

  - "lib/render\.tcl"

    Package __[mustache::render](mustache\_render\.md)__\.

# <a name='section5'></a>Extended Build Actions

Our build\-system is based on __kettle__, as already explained in the
*[Mustache \- The Installer's Guide](mustache\_howto\_installation\.md)*\.
Beyond the targets useful for installation it also provides targets aiding
developers and maintainers\. These are:

  - Validation of the documentation

        % /path/to/mustache/build\.tcl validate\-doc

  - Regeneration of the embedded documentation

        % /path/to/mustache/build\.tcl doc

  - Regeneration of the figures for the documentation

        % /path/to/mustache/build\.tcl figures

  - Execution of the test\-suite

    The most basic execution of the test\-suite is done with

        % /path/to/mustache/build\.tcl test

    When the test\-suite reports issues with the framework use of the more
    extended form below is indicated, with a __<stem>__ of your choice\. This
    will generate a number of files whose name starts with the prefix "<stem>\."\.
    These will contain extended test logs, details about errors and failures,
    etc\.

        % /path/to/mustache/build\.tcl test \-\-log <stem>

# <a name='section6'></a>Architecture & Concepts

All packages belong to one of two layers, as shown below:

![](\.\./\.\./image/architecture\.png)

Note that:

  - Packages marked with a dashed border are private\.

  - Packages marked with an unbroken blue border are fully public\.

The dependencies between the packages are very straight\-forward:

![](\.\./\.\./image/pkg\_dependencies\.png)

# <a name='section7'></a>Related Documents

  1. *[Mustache \- Introduction to the project](mustache\_introduction\.md)*

  1. *[Mustache \- License](mustache\_license\.md)*

  1. *[Mustache \- Log of Changes](mustache\_changes\.md)*

  1. *[Mustache \- How To Get The Sources](mustache\_howto\_get\_sources\.md)*

  1. *[Mustache \- The Installer's Guide](mustache\_howto\_installation\.md)*

  1. *Mustache \- The Developer's Guide*

# <a name='section8'></a>Bugs, Ideas, Feedback

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
