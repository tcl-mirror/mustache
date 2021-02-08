
[//000000001]: # (mustache\-introduction \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_introduction\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache\-introduction\(n\) 1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\-introduction \- Mustache \- Introduction to the project

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Description](#section1)

  - [System Architecture](#section2)

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

# <a name='section2'></a>System Architecture

All packages belong to one of two layers, as shown below:

![](\.\./\.\./image/architecture\.png)

Note that:

  - Packages marked with a dashed border are private\.

  - Packages marked with an unbroken blue border are fully public\.

The dependencies between the packages are very straight\-forward:

![](\.\./\.\./image/pkg\_dependencies\.png)

# <a name='section3'></a>Related Documents

  1. *Mustache \- Introduction to the project*

  1. *[Mustache \- License](mustache\_license\.md)*

  1. *[Mustache \- Log of Changes](mustache\_changes\.md)*

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
