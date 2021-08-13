# Welcome

Welcome to my Mustache project. It provides a set of
five related Tcl packages for the parsing and rendering of
[mustache-style](https://mustache.github.io) logic-less templates,
plus an application for easy command-line access to the functionality.

# Ticket tracking

You are reading this document from either of the two fossil
repositories for the project, i.e.

  - [Primary repository](http://core.tcl-lang.org/akupries/mustache)
  - [ChiselApp Mirror](https://chiselapp.com/user/andreas_kupries/repository/mustache/index)

A git mirror of the same is available at
[github](https://github.com/andreas-kupries/mustache).

__Please__ use only the
[official ticket tracker](https://core.tcl-lang.org/akupries/mustache/reportlist)
for tickets.

Tickets at github will be ignored, or simply closed with a reference
to the primary site.

# Guides and other Documentation

   * [Introduction](../embedded/md/doc/files/mustache_introduction.md)
   * [Release Notes](../embedded/md/doc/files/mustache_changes.md)
   * [License](../embedded/md/doc/files/mustache_license.md)
   * [The Application](../embedded/md/doc/files/mustache_application.md)

   * Package References:
       * [Main Package](../embedded/md/doc/files/mustache.md)
       * [Rendering contexts](../embedded/md/doc/files/mustache_context.md)
       * [Data Frames](../embedded/md/doc/files/mustache_frame.md)
       * [Template parsing](../embedded/md/doc/files/mustache_parse.md)
       * [Template rendering](../embedded/md/doc/files/mustache_render.md)

   * [How To Get The Sources](../embedded/md/doc/files/mustache_howto_get_sources.md)
   * [How To Build And Install mustache](../embedded/md/doc/files/mustache_howto_installation.md)
   * [The Developer's Guide](../embedded/md/doc/files/mustache_howto_development.md)

# Related

__Note__ that I am aware of
[mustache.tcl](https://github.com/ianka/mustache.tcl).

That implementation is pure a template interpreter, without separation
of compiler and render phases. For nested sections it reparses the
internal parts over and over again.

This set of packages on the other hand is capable of parsing a given
template once and then re-using it multiple times.