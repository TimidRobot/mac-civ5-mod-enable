mac-civ5-mod-enable
===================

Updates the Steam version of Sid Meier's Civilization 5 on the Mac to enable
mods and installs any subscribed Steam mods.

As a bonus it performs the [SQLite vacuum maintenance][vacuum] on all of the
game's user data DBs.

Easy peasy lemon squeezy.

[vacuum]: http://www.sqlite.org/lang_vacuum.html


Requirements
=============

- Mac OS X which comes with [Terminal]
- [Mac Homebrew][brew]
- The `p7zip` package installed via `brew install p7zip`

[Terminal]: http://en.wikipedia.org/wiki/Terminal_(OS_X)

[brew]: http://brew.sh/


Usage
=====

1. Download [civ5-mod-enable.sh]
2. Open Terminal (located in Applications » Utilities)
3. Assuming you downloaded the script to Downloads, execute the following
   commands in Terminal:

        cd Downloads
        bash civ5-mod-enable.sh

[civ5-mod-enable.sh]:
  https://raw.github.com/TimZehta/mac-civ5-mod-enable/master/civ5-mod-enable.sh


Troubleshooting
===============

The script can also be run with the `-P` option to purge existing mods and
the Civ5 Mods Database (`Civ5ModsDatabase.db`):

    bash civ5-mod-enable.sh -P


License
=======

- [LICENSE][license] ([MIT License][mit])

[license]: https://github.com/TimZehta/mac-civ5-mod-enable/blob/master/LICENSE
[mit]: http://www.opensource.org/licenses/MIT
