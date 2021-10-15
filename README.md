# xfce-dotFiles
**`get.sh` is broken. Will fix it sometime later in future**

XFCE Dot Files using [GNU Stow](https://www.gnu.org/software/stow/)

## Screenshot
![Screenshot](https://raw.githubusercontent.com/njkevlani/xfce-dotFiles/master/misc/images/Scrot.png)

## Introduction
This are my configuration files for Xfce.. `get.sh` is used to copy configuration from local machine to this repository.

## How to set this at local machine?
- Clone this repository.

`git clone https://github.com/njkevlani/xfce-dotFiles.git && cd xfce-dotFiles`

Use stow to make symlinks files from `home` folder of this repo into local system.

`stow -v -t $HOME home`

For creating symlinks for files from `etc`, run:
`stow -v -t /etc /etc`

This command tells stow following things
  - Be verbose (`-v`)
  - Target directory for making symlinks is $HOMW (`-t $HOME`)
  - Make symlinks from the folder `home`

You can add `-n` option to this command to see what links will be made **without writing them on file system**.

## What else does this repository contain?

- [`/awesome`](https://github.com/njkevlani/xfce-dotFiles/tree/master/awesome) contains some cool things to customize your setup.
- [`/scripts`](https://github.com/njkevlani/xfce-dotFiles/tree/master/scripts) contains some cool scripts to ease day to day tasks and some eye candy as well!
- [`/archlinux`](https://github.com/njkevlani/xfce-dotFiles/tree/master/archlinux) contains base packages that I use from archlinux official repositories and AUR.
- Following config files are included in this repository:
  - Bash profile
  - vimrc
  - gtk configs
  - VSCode settings and keybindings
  - Xmodmap config
  - Xfce4 keyboard shortcuts
  - Xfwm4 config
  - Xfce4-panel config
  - xfce4-terminal config
