# dotfiles

My dotfiles using [GNU Stow](https://www.gnu.org/software/stow/)

## Screenshot

![Screenshot](/misc/images/screenshot.png)

## Usage

- Clone this repository.

```bash
git clone https://github.com/njkevlani/dotfiles.git
cd dotfiles
```

Use stow to make symlink of the configs from this repo to your `~/.config`
directory.

```bash
stow -v zsh
stow -v git
# and so on...
```

You can add `-n` option to this command to see what symlink will be created
**without writing them on filesystem**.

```bash
[0]-[dotfiles(main)]-λ stow -nv zsh
LINK: .cache/zsh => ../dotfiles/zsh/.cache/zsh
LINK: .config/zsh => ../dotfiles/zsh/.config/zsh
LINK: .zshrc => dotfiles/zsh/.zshrc
WARNING: in simulation mode so not modifying filesystem.
```

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
7. Bind logitech mx master mouse gestures workspace commands in niri.
