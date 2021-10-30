# dotfiles
My dotfiles using [GNU Stow](https://www.gnu.org/software/stow/)

## xfce configs
This branch contains config for version controlling xfce config files.

There are some issues in this:
1. `xfconfd` keeps config files in memory and overrides them on some time interval. [Source](https://forum.xfce.org/viewtopic.php?pid=51746#p51746).
2. When `xfconfd` is overwriting these config files, it does not care about symlinks. Stow works on symlinks. Hence xfce config files can not be handled with stow at the moment.
3. genmon plugin requires script paths to be absolute. Hence it will include `~/home/someSpecificUsername`. Which is an issue when using these genmon plugins on systems with different username.
4. xfce config files are `xml`s. It is not a big issue but it would be better if some other format like `toml` was made available.

## Screenshot
![Screenshot](/misc/images/Scrot.png)

## How to set this at local machine?
- Clone this repository.

```bash
git clone https://github.com/njkevlani/dotfiles.git
cd dotfiles
```

Make symlinks for config files of any config-directory(directories in root of this repo) with stow like:

```bash
stow -v bash
stow -v git
# and so on...
```

You can add `-n` option to this command to see what links will be made **without writing them on file system**.
```bash
$ stow -nv bash/
LINK: .bashrc => dotfiles/bash/.bashrc
LINK: .bash_profile => dotfiles/bash/.bash_profile
LINK: .bashrc_linux => dotfiles/bash/.bashrc_linux
LINK: .bashrc_mac => dotfiles/bash/.bashrc_mac
WARNING: in simulation mode so not modifying filesystem.
```

## What else does this repository contain?

- [`/misc/awesome`](/misc/awesome) contains some cool things to customize your setup.
- [`/misc/scripts`](/misc/scripts) contains some cool scripts to ease day to day tasks and some eye candy as well!
- [`/misc/archlinux`](/misc/archlinux) contains base packages that I use from archlinux official repositories and AUR.
