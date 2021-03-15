
[//000000001]: # (mustache\-installation \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_howto\_installation\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache\-installation\(n\) 1\.1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\-installation \- Mustache \- The Installer's Guide

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Description](#section1)

  - [Requisites](#section2)

      - [Tcl](#subsection1)

      - [TclOO](#subsection2)

      - [Kettle](#subsection3)

  - [Build & Installation](#section3)

  - [Related Documents](#section4)

  - [Bugs, Ideas, Feedback](#section5)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)*\.

The audience of this document are anyone wishing to build the Mustache project,
for either themselves, or others\.

For developers intending to work on the packages themselves we provide
additional documents, please see the section for [Related
Documents](#section4)\.

Please read *[Mustache \- How To Get The
Sources](mustache\_howto\_get\_sources\.md)* first, if that was not done
already\. Here we assume that the sources are already available in a directory of
your choice\.

# <a name='section2'></a>Requisites

## <a name='subsection1'></a>Tcl

This project requires a working installation of Tcl 8\.5, or higher\.

Use whatever you are comfortable with, as long as it provides Tcl 8\.5, or
higher\.

An easy way to get a proper installation of a recent Tcl 8\.5, \(which I
recommend\) is to download and install
[ActiveState](https://www\.activestate\.com)'s
[ActiveTcl](https://www\.activestate\.com/activetcl) 8\.5 for your platform\.
Just follow the link and instruction on that site\.

After the installation of ActiveTcl 8\.5 simply run the command

    teacup update

This will install a lot more packages than found in the distribution alone\.
\(Disclosure: I, Andreas Kupries, did work for ActiveState until 2015,
maintaining ActiveTcl and TclDevKit\)\.

Do you wish to build Tcl on your own ? The sources of all versions can be found
at

  - Tcl

    [https://core\.tcl\-lang\.org/tcl](https://core\.tcl\-lang\.org/tcl)

together with the necessary instructions on how to build it\.

If there are problems with building, installing, or using Tcl and its packages
please file a bug against Tcl, or the vendor of your distribution, and not
__[mustache](mustache\.md)__\.

## <a name='subsection2'></a>TclOO

The framework uses the __TclOO__ package in its implementation\. This package
requires Tcl 8\.5 or higher\.

In Tcl 8\.6 the package is part of the core itself, without requiring a separate
installation\.

For Tcl 8\.5 it has to be installed separately\.

Out of the many possibilites for getting TclOO \(OS vendor, os\-independent
vendor, building from sources\) use whatever you are comfortable with\.

For myself, I am most comfortable with using
[ActiveState](https://www\.activestate\.com)'s
[ActiveTcl](https://www\.activestate\.com/activetcl) distribution and TEApot\.

See the previous section \([Tcl](#subsection1)\) for disclosure and
information on how to get it\.

Assuming that ActiveTcl got installed running the command

    teacup install TclOO

will install the package for your platform, if you have not done the more
inclusive

    teacup update

to get everything and the kitchensink\.

For those wishing to build and install TclOO on their own, the relevant sources
can be found at
[https://core\.tcl\-lang\.org/tcloo](https://core\.tcl\-lang\.org/tcloo) together
with the necessary instructions on how to build it\.

If there are problems with building, installing, or using TclOO and its packages
please file a bug against TclOO, or the vendor of your distribution, and not
__[mustache](mustache\.md)__\.

## <a name='subsection3'></a>Kettle

This project uses the Kettle application and package as its build system\.

Please go to either the main repository at
[https://core\.tcl\-lang\.org/akupries/kettle](https://core\.tcl\-lang\.org/akupries/kettle)
or the backups at
[https://chiselapp\.com/user/andreas\_kupries/repository/Kettle](https://chiselapp\.com/user/andreas\_kupries/repository/Kettle)
and
[https://github\.com/andreas\-kupries/kettle](https://github\.com/andreas\-kupries/kettle)
and follow the instructions given at these sites to create a working
installation\. They are not repeated here\. If there are problems with these
instructions please file a bug against the Kettle project, and not
__[Mustache](mustache\.md)__\.

# <a name='section3'></a>Build & Installation

Mustache uses the Kettle application and package to handle building and
installation\. It is assumed to be installed and working\. Please see section
[Kettle](#subsection3) in [Requisites](#section2) for more
information\.

Note that all access to Kettle is mediated by the "build\.tcl" script, found in
the top\-level directory of the project\.

For the most basic installation of Mustache run

    % /path/to/mustache/build.tcl install

This command uses the __kettle__ application found in the , and the
associated __tclsh__\.

The command builds all packages and applications of Mustache, and then installs
them so that the associated __tclsh__ has access to them\. Any applications
will become siblings of __tclsh__\.

For more control about which version of __kettle__ and/or __tclsh__ gets
used run either

    % /path/to/kettle /path/to/mustache/build.tcl install

or even

    % /path/to/tclsh /path/to/kettle /path/to/mustache/build.tcl install

to specify the exact files to use\.

On Windows it is possible to invoke the the file "build\.tcl" with a
double\-click\. This will start a graphical interface to the system, with buttons
for all the possible actions, which includes 'install'ation\.

On unix the same GUI is acessible by invoking "build\.tcl" with the arguments
__gui__, i\.e\. as

    % /path/to/mustache/build.tcl gui

To get help about the methods of "build\.tcl", and their complete syntax, simply
invoke "build\.tcl" like

    % /path/to/mustache/build.tcl gui

# <a name='section4'></a>Related Documents

  1. *[Mustache \- Introduction to the project](mustache\_introduction\.md)*

  1. *[Mustache \- License](mustache\_license\.md)*

  1. *[Mustache \- Log of Changes](mustache\_changes\.md)*

  1. *[Mustache \- How To Get The Sources](mustache\_howto\_get\_sources\.md)*

  1. *Mustache \- The Installer's Guide*

  1. *[Mustache \- The Developer's Guide](mustache\_howto\_development\.md)*

# <a name='section5'></a>Bugs, Ideas, Feedback

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
