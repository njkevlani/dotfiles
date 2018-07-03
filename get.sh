#!/bin/sh

dotDirectory=$(pwd)

# Usage info
show_help() {
  cat << EOF
Usage: ${0##*/} OPTION
    -h          display this help and exit
    -b          get bash profile
    -g          get gtk settings
    -f          get font config
    -p          get xfce4-panel settings
    -t          get xfce4-terminal settings
    -c          get VSCode settings
    -i          get IntelliJ settings
    -k          get keybindings in xfce4
    -v          get vimrc
    -x          get settings for xfce4 and xfwm4
    -m          get xmodemap key mapping
    -e          get everything
    -l          list the files that will be deleted
EOF
}

# list delete file
list_delete_file() {
  cat << EOF
Following files will be deleted with respective options:
    -b          ./.bashrc and ./.bash_profile
    -g          ./.gtkrc-2.0 and ./.config/gtk-3.0/settings.ini
    -f          ./.config/fontconfig/conf.d/01-emoji.conf
    -p          ./.config/xfce4/panel/genmon-* and ./.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    -t          ./.config/xfce4/terminal/terminalrc
    -c          ./.config/Code/User/keybindings.json and ./.config/Code/User/settings.json
    -i          None
    -k          ./.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    -v          ./.vimrc
    -x          ./.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml and ./.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    -m          ./.Xmodmap
EOF
}

# Get bash profile
get_bash() {
  cp $HOME/.bash_profile $dotDirectory/.bash_profile
  echo "Cpoied $HOME/.bash_profile to $dotDirectory/.bash_profile"
  cp $HOME/.bashrc $dotDirectory/.bashrc
  echo "Cpoied $HOME/.bashrc to $dotDirectory/.bashrc"
}

get_gtk() {
  cp $HOME/.gtkrc-2.0 $dotDirectory/.gtkrc-2.0
  echo "Cpoied $HOME/.gtkrc-2.0 to $dotDirectory/.gtkrc-2.0"
  cp $HOME/.config/gtk-3.0/settings.ini $dotDirectory/settings.ini
  echo "Cpoied $HOME/.config/gtk-3.0/settings.ini to $dotDirectory/settings.ini"
}

# Get font config
# get_font_config() {
#   cp $HOME/.config/fontconfig/conf.d $dotDirectory/fontconfig -r
#   echo "Copied $HOME/.config/fontconfig/conf.d/ to $dotDirectory/fontconfig/"
# }

# Get xfce4-panel
get_panel() {
  mkdir -p $dotDirectory/genmon_xfce4_panel
  for f in $HOME/.config/xfce4/panel/*; do
    cp $f $dotDirectory/genmon_xfce4_panel/
    echo "Copied $f to $dotDirectory/genmon_xfce4_panel/"
  done

  mkdir -p $dotDirectory/xfconf/xfce-perchannel-xml
  cp $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml $dotDirectory/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  echo "Cpoied $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml to $dotDirectory/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
}

# Get xfce4-terminal
get_terminal() {
  cp $HOME/.config/xfce4/terminal/terminalrc $dotDirectory/terminalrc
  echo "Cpoied $HOME/.config/xfce4/terminal/terminalrc to $dotDirectory/terminalrc"
}

# Get VSCode settings and keybindings
get_vscode() {
  mkdir -p $dotDirectory/VSCode
  cp $HOME/.config/Code/User/keybindings.json $dotDirectory/VSCode/keybindings.json
  echo "Cpoied $HOME/.config/Code/User/keybindings.json to $dotDirectory/.config/Code/User/keybindings.json"
  cp $HOME/.config/Code/User/settings.json $dotDirectory/VSCode/settings.json
  echo "Cpoied $HOME/.config/Code/User/settings.json to $dotDirectory/VSCode/settings.json"
}

# Get IntelliJ settings
get_intellij() {
  echo "Yet remaining."
}

# Get xfce4 keybindings
get_keybinding() {
  mkdir -p $dotDirectory/xfconf/xfce-perchannel-xml
  cp $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $dotDirectory/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
  echo "Cpoied $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml to $dotDirectory/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
}

get_vim() {
  cp $HOME/.vimrc $dotDirectory/.vimrc
  echo "Cpoied $HOME/.vimrc to $dotDirectory/.vimrc"
}

get_xfce() {
  mkdir -p $dotDirectory/xfconf/xfce-perchannel-xml
  cp $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml $dotDirectory/xfconf/xfce-perchannel-xml/xfwm4.xml
  echo "Cpoied $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml to $dotDirectory/xfconf/xfce-perchannel-xml/xfwm4.xml"
  cp $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml $dotDirectory/xfconf/xfce-perchannel-xml/xsettings.xml
  echo "Cpoied $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml to $dotDirectory/xfconf/xfce-perchannel-xml/xsettings.xml"
}

get_xmodmap() {
  cp $HOME/.Xmodmap $dotDirectory/.Xmodmap
  echo "Cpoied $HOME/.Xmodmap to $dotDirectory/.Xmodmap"
}

if [ $# -eq 0 ];
then
  show_help
  exit 0
else
  while getopts hbgfptcikvxmel opt; do
    case $opt in
      h)
        show_help
        exit 0
        ;;

      l)  list_delete_file
        ;;

      e)  get_bash
        get_gtk
        get_font_config
        get_panel
        get_terminal
        get_vim
        get_vscode
        get_intellij
        get_keybinding
        get_xmodmap
        get_xfce
        ;;

      b)  get_bash
        ;;

      g)  get_gtk
        ;;

      f)  get_font_config
        ;;

      p)  get_panel
        ;;

      t)  get_terminal
        ;;

      v)  get_vim
        ;;

      c)  get_vscode
        ;;

      i)  get_intellij
        ;;

      k)  get_keybinding
        ;;

      m)  get_xmodmap
        ;;

      x)  get_xfce
        ;;

      *)
        show_help >&2
        exit 1
        ;;
    esac
  done
fi
