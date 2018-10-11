# ArchBase
## Introduction
This is a set of basic stuff to setup Arch Linux with Xfce Desktop Environment. It assumes that you have
- Created a partition, mounted it.
- `packstrap`ed
- `arch-chroot`ed
- Installed `yay`

## What this repository contains?
- **pkgList.txt**: List of base packages to be installed
- **pkgList-aur.txt**: List of AUR packages to be installed

## How to install from file?
- `pacman -S - < pkgList.txt`

- `yay -S - < pkgList-aur.txt`