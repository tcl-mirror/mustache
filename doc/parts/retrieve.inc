[comment {--- Standard section about retrieval from fossil --}]

Assuming that you simply wish to look at the sources, or build a
specific revision, the easiest way of retrieving it is to use one of
the following links:

[list_begin enum]
[enum]	[uri [vset project/core/url  ]/tarball/trunk/[vset PTITLE].tar.gz {Core Tarball}]
[enum]	[uri [vset project/core/url  ]/zip/trunk/[vset PTITLE].zip {Core Zip Archive}]
[enum]	[uri [vset project/chisel/url]/tarball/trunk/[vset PTITLE].tar.gz {ChiselApp Tarball}]
[enum]	[uri [vset project/chisel/url]/zip/trunk/[vset PTITLE].zip {ChiselApp Zip Archive}]
[enum]	[uri [vset project/github/url]/archive/master.zip {Github Zip Archive}]
[list_end]

[para] To generalize the above, replace [const trunk] in the links
above with any commit id, tag or branch name to retrieve an archive
for that commit, the last commit having the tag, or the last commit on
the named branch.

[para] As an example, use the links below to retrieve the last commit
for tag [const v1.1]:

[list_begin enum]
[enum]	[uri [vset project/core/url  ]/tarball/v1.1/[vset PTITLE].tar.gz {Core v1.1 Tarball}]
[enum]	[uri [vset project/core/url  ]/zip/v1.1/[vset PTITLE].zip {Core v1.1 Zip Archive}]
[enum]	[uri [vset project/chisel/url]/tarball/v1.1/[vset PTITLE].tar.gz {ChiselApp v1.1 Tarball}]
[enum]	[uri [vset project/chisel/url]/zip/v1.1/[vset PTITLE].zip {ChiselApp v1.1 Zip Archive}]
[enum]	[uri [vset project/github/url]/archive/v1.1.zip {Github v1.1 Zip Archive}]
[list_end]

[para] [strong {Beware however}] that fossil's [const trunk] branch is
called [const master] in github, and that github commit ids do not
match fossil commit ids, at all. Only tags and the other branch names
match.
