# mac-civ5-mod-enable

Updates the Steam version of Sid Meier's Civilization 5 on the Mac to enable
mods and installs any subscribed Steam mods.

As a bonus it performs the [SQLite vacuum maintenance][vacuum] on all of the
game's user data DBs.

Easy peasy lemon squeezy.

[vacuum]: http://www.sqlite.org/lang_vacuum.html


## Install

1. [Install Homebrew][brewinstall] -- The missing package manager for
   macOS
2. Install `p7zip`:
    ```shell
    brew install p7zip
    ```
3. Add the TimidRobot "tap" and install dullaplan:
    ```shell
    brew tap TimidRobot/tap
    brew install civ-5-mod-enable
    ```

Alternatively, since `civ5-mod-enable.sh` is a bash script without esoteric
dependencies, you can simply download it and ensure it is in your `PATH`.

[brewinstall]: http://brew.sh/#install


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

```shell
civ5-mod-enable.sh -P
```


## Requirements

- macOS which comes with [Terminal][terminal]
- [Civilization V via Steam][civ5]
- [Mac Homebrew][brew]

[terminal]: http://en.wikipedia.org/wiki/Terminal_(macOS)
[civ5]: http://store.steampowered.com/app/8930/
[brew]: http://brew.sh/


## License

- [`LICENSE`][LICENSE] (Expat/[MIT License][mit])

[mit]: http://www.opensource.org/licenses/MIT
