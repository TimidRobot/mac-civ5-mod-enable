# mac-civ5-mod-enable

Updates the Steam version of Sid Meier's Civilization 5 on the Mac to enable
mods and installs any subscribed Steam mods.

As a bonus it performs the [SQLite vacuum maintenance][vacuum] on all of the
game's user data DBs.

Easy peasy lemon squeezy.

[vacuum]: http://www.sqlite.org/lang_vacuum.html


## Install

1. [Install Homebrew][homebrew_install] -- The missing package manager for
   macOS
2. Install `p7zip`

```
brew install p7zip
```

3. Add the TimZehta "tap" and install dullaplan::

```
brew tap TimZehta/tap
brew install civ-5-mod-enable
```

Alternatively, since `civ5-mod-enable.sh` is a bash script without esoteric
dependencies, you can simply download it and ensure it is in your `PATH`.

[homebrew_install]: http://brew.sh/#install


## Usage

```
Usage:  civ5-mod-enable.sh [ -P ]
        civ5-mod-enable.sh -h

Updates Mac Civ5 to enable mods and installs subscribed Steam mods.

Options:
    -h      show this help message and exit
    -P      Purge existing mods before extracting Steam mod
```

## Troubleshooting

The script can also be run with the `-P` option to purge existing mods and
the Civ5 Mods Database (`Civ5ModsDatabase.db`):

```
bash civ5-mod-enable.sh -P
```


## Requirements

- macOS which comes with [Terminal]
- [Civilization V via Steam]
- [Mac Homebrew][brew]

[Terminal]: http://en.wikipedia.org/wiki/Terminal_(OS_X)
[Civilization V via Steam]: http://store.steampowered.com/app/8930/
[brew]: http://brew.sh/


## License

- [LICENSE][license] ([MIT License][mit])

[license]: https://github.com/TimZehta/mac-civ5-mod-enable/blob/master/LICENSE
[mit]: http://www.opensource.org/licenses/MIT
