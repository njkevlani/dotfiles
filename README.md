# xfce-dotFiles
XFCE Dot Files

## Screenshot
![Screenshot](https://raw.githubusercontent.com/njkevlani/xfce-dotFiles/master/images/Scrot.png)

## Introduction
This are my configuration files for Xfce. `set.sh` script is used to set configuration on local machine. `get.sh` is used to copy configuration from local machine to this repository. Basically `set.sh` creates soft links(`ln`) of files in this repository to the configuration directory on local machine.

## How to set this at local machine?
- Clone this repository.

`git clone https://github.com/njkevlani/xfce-dotFiles.git && cd xfce-dotFiles`

- Mark set.sh executable.

`chmod +x set.sh`

- View help message.

`./set.sh -h`

- List which file are changed.

`./set.sh -l`

- Set everything. **This will delete all corresponding files.**

`./set.sh -e`


## How to get local machine configuration?

- Mark get.sh executable.

`chmod +x get.sh`

- View help message.

`./get.sh -h`

- List which file are changed.

`./get.sh -l`

- Get everything. **This will delete all corresponding files.**

`./get.sh -e`

## What else does this repository contain?

- [`/awesome`](https://github.com/njkevlani/xfce-dotFiles/tree/master/awesome) contains some cool things to customize your setup.
- [`/scripts`](https://github.com/njkevlani/xfce-dotFiles/tree/master/scripts) contains some cool scripts to ease day to day tasks and some eye candy as well!
- Following config files are included in this repository:
  - Bash profile
  - gtk configs
  - VSCode settings and keybindings
  - Xmodmap config
  - Xfce4 keyboard shortcuts
  - Xfwm4 config
  - Xfce4-panel config
  - xfce4-terminal config