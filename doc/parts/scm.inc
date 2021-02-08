[comment {--- Standard section about fossil in general --}]

For the curious (or a developer-to-be), the sources of this project
are managed by the [vset fossil].

Binaries for popular platforms can be found directly at its
[vset fossil/get].

[para]

With that tool available the full history of our project can be
retrieved via:

[example_begin]
fossil clone [vset project/core] [vset PROJECT].fossil
[example_end]

followed by

[example_begin]
mkdir [vset PROJECT]
cd    [vset PROJECT]
fossil open ../[vset PROJECT].fossil
[example_end]

to get a checkout of the head of the trunk.
