# dotfiles

My dotfiles using [GNU Stow](https://www.gnu.org/software/stow/)

## Screenshot

![Screenshot](/misc/images/screenshot.png)

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

## TODO

1. Ensure Installed script to make sure dependencies are installed which runs once after boot.
    a. zsh zsh-syntax-highlighting fzf stow git neovim cliphist wl-clipboard libnotify brightnessctl
2. Copy from sway-fedora-config: scripts for brightnessctl and volume control.
3. [nvim] In snacks.nvim explorer, show relevant options on right-click menu.
4. Idea for external monitor brightness control
    1. <https://github.com/basecamp/omarchy/issues/2302>
    2. Something similar to <https://github.com/MonitorControl/MonitorControl> for Linux.
5. Notification history.
6. OSD Notifications for volume/brightness control.
