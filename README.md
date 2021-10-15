# xfce-dotFiles
My dotfiles using [GNU Stow](https://www.gnu.org/software/stow/)

## Screenshot
![Screenshot](/misc/images/Scrot.png)

## How to set this at local machine?
- Clone this repository.

```bash
git clone https://github.com/njkevlani/xfce-dotFiles.git
cd xfce-dotFiles
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
LINK: .bashrc => xfce-dotFiles/bash/.bashrc
LINK: .bash_profile => xfce-dotFiles/bash/.bash_profile
LINK: .bashrc_linux => xfce-dotFiles/bash/.bashrc_linux
LINK: .bashrc_mac => xfce-dotFiles/bash/.bashrc_mac
WARNING: in simulation mode so not modifying filesystem.
```

## What else does this repository contain?

- [`/misc/awesome`](/misc/awesome) contains some cool things to customize your setup.
- [`/misc/scripts`](/misc/scripts) contains some cool scripts to ease day to day tasks and some eye candy as well!
- [`/misc/archlinux`](/misc/archlinux) contains base packages that I use from archlinux official repositories and AUR.
