
[//000000001]: # (mustache\-howto\-get\-sources \- Mustache\. Packages for logic\-less templating)
[//000000002]: # (Generated from file 'mustache\_howto\_get\_sources\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2019\-2021 Andreas Kupries)
[//000000004]: # (Copyright &copy; 2019\-2021 Documentation, Andreas Kupries)
[//000000005]: # (mustache\-howto\-get\-sources\(n\) 1\.1 doc "Mustache\. Packages for logic\-less templating")

<hr> [ <a href="../../../../../../home">Home</a> &#124; <a
href="../../toc.md">Main Table Of Contents</a> &#124; <a
href="../toc.md">Table Of Contents</a> &#124; <a
href="../../index.md">Keyword Index</a> ] <hr>

# NAME

mustache\-howto\-get\-sources \- Mustache \- How To Get The Sources

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Description](#section1)

  - [Location](#section2)

  - [Retrieval](#section3)

  - [Source Code Management](#section4)

  - [Related Documents](#section5)

  - [Bugs, Ideas, Feedback](#section6)

  - [Keywords](#keywords)

  - [Copyright](#copyright)

# <a name='description'></a>DESCRIPTION

Welcome to the Mustache project for Tcl, written by Andreas Kupries\.

It provides a set of five related Tcl packages for the parsing and rendering of
[mustache](https://mustache\.github\.io/)\-style logic\-less templates, plus an
application for easy command\-line access to the functionality\.

For availability please read *Mustache \- How To Get The Sources*\.

The audience of this document are anyone wishing to either have just a look at
Mustache's sources, or to build the project, or to extend and modify it\. The
list of [Related Documents](#section5) provides references to information
for the latter two\.

# <a name='section2'></a>Location

The official repository for Kettle can be found at
[https:/core\.tcl\-lang\.org/akupries/mustache](https:/core\.tcl\-lang\.org/akupries/mustache),
with mirrors at
[https://chiselapp\.com/user/andreas\_kupries/repository/mustache](https://chiselapp\.com/user/andreas\_kupries/repository/mustache)
and
[https://github\.com/andreas\-kupries/mustache](https://github\.com/andreas\-kupries/mustache),
in case of trouble with the main location\.

# <a name='section3'></a>Retrieval

Assuming that you simply wish to look at the sources of the project, or build a
specific revision, the easiest way of retrieving the sources is to:

  1. Log as "anonymous" into the repository \(see [Location](#section2)\)\.
     Use the semi\-random password in the captcha\.

  1. Go to the "Timeline"\.

  1. Choose the revision you wish to have and

  1. follow its link to its detailed information page\.

  1. On that page, choose either the "ZIP" or "Tarball" link to get a copy of
     this revision in the format of your choice\.

# <a name='section4'></a>Source Code Management

For the curious \(or a developer\-to\-be\), the sources of this project are managed
by the [Fossil SCM](https://www\.fossil\-scm\.org)\. Binaries for popular
platforms can be found directly at its [download
page](https://www\.fossil\-scm\.org/download\.html)\.

With that tool available the full history of our project can be retrieved via:

> fossil clone [https:/core\.tcl\-lang\.org/akupries/mustache](https:/core\.tcl\-lang\.org/akupries/mustache) mustache\.fossil

followed by

    mkdir mustache
    cd    mustache
    fossil open ../mustache.fossil

to get a checkout of the head of the trunk\.

# <a name='section5'></a>Related Documents

  1. *[Mustache \- Introduction to the project](mustache\_introduction\.md)*

  1. *[Mustache \- License](mustache\_license\.md)*

  1. *[Mustache \- Log of Changes](mustache\_changes\.md)*

  1. *Mustache \- How To Get The Sources*

  1. *[Mustache \- The Installer's Guide](mustache\_howto\_installation\.md)*

  1. *[Mustache \- The Developer's Guide](mustache\_howto\_development\.md)*

# <a name='section6'></a>Bugs, Ideas, Feedback

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
