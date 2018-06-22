#!/bin/sh

dotDirectory=$(pwd)

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} OPTION
    -h          display this help and exit
    -b          set bash profile
    -g          set gtk settings
    -f          set font config
    -p          set xfce4-panel settings
    -t          set xfce4-terminal settings
    -c          set VSCode settings
    -i          set IntelliJ settings
    -k          set keybindings in xfce4
    -v          set vimrc
    -x          set settings for xfce4 and xfwm4
    -m          set xmodemap key mapping
    -e          set everything
    -l          list the files that will be deleted
EOF
}

# list delete file
list_delete_file() {
cat << EOF
Following files will be deleted with respective options:
    -b          $HOME/.bashrc and $HOME/.bash_profile
    -g          $HOME/.gtkrc-2.0 and $HOME/.config/gtk-3.0/settings.ini
    -f          $HOME/.config/fontconfig/conf.d/01-emoji.conf
    -p          $HOME/.config/xfce4/panel/genmon-* and $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    -t          $HOME/.config/xfce4/terminal/terminalrc
    -c          $HOME/.config/Code/User/keybindings.json and $HOME/.config/Code/User/settings.json
    -i          None
    -k          $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    -v          $HOME/.vimrc
    -x          $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml and $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    -m          $HOME/.Xmodmap
EOF
}

# Set bash profile
set_bash() {
  ln -sf $dotDirectory/.bash_profile $HOME/.bash_profile
  echo "Created force link at $HOME/.bash_profile"
  ln -sf $dotDirectory/.bashrc $HOME/.bashrc
  echo "Created force link at $HOME/.bashrc"
}

set_gtk() {
  ln -sf $dotDirectory/.gtkrc-2.0 $HOME/.gtkrc-2.0
  echo "Created force link at $HOME/.gtkrc-2.0"
  mkdir -p $HOME/.config/gtk-3.0
  ln -sf $dotDirectory/settings.ini $HOME/.config/gtk-3.0/settings.ini
  echo "Created force link at $HOME/.config/gtk-3.0/settings.ini"
}

# Set font config
set_font_config() {
  mkdir -p .config/fontconfig/conf.d
  ln -sf $dotDirectory/01-emoji.conf $HOME/.config/fontconfig/conf.d/01-emoji.conf
  echo "Created force link at $HOME/.config/fontconfig/conf.d/01-emoji.conf"
}

# Set xfce4-panel
set_panel() {
  mkdir -p $HOME/.config/xfce4/panel
  for f in $dotDirectory/genmon_xfce4_panel/genmon-*; do
      ln -sf $f $HOME/.config/xfce4/panel/
      echo "Created force link at $HOME/.config/xfce4/panel/"
  done

  mkdir -p $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
  ln -sf $dotDirectory/xfconf/xfce-perchannel-xml/xfce4-panel.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  echo "Created force link at $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
}

# Set xfce4-terminal
set_terminal() {
  mkdir -p $HOME/.config/xfce4/terminal
  ln -sf $dotDirectory/terminalrc $HOME/.config/xfce4/terminal/terminalrc
  echo "Created force link at $HOME/.config/xfce4/terminal/terminalrc"
}

# Set VSCode settings and keybindings
set_vscode() {
  mkdir -p $HOME/.config/Code/User
  ln -sf $dotDirectory/VSCode/keybindings.json $HOME/.config/Code/User/keybindings.json
  echo "Created force link at $HOME/.config/Code/User/keybindings.json"
  ln -sf $dotDirectory/VSCode/settings.json $HOME/.config/Code/User/settings.json
  echo "Created force link at $HOME/.config/Code/User/settings.json"
}

# Set IntelliJ settings
set_intellij() {
  echo "Yet remaining."
}

# Set xfce4 keybindings
set_keybinding() {
  mkdir -p $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
  ln -sf $dotDirectory/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
  echo "Created force link at $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
}

set_vim() {
  ln -sf $dotDirectory/.vimrc $HOME/.vimrc
  echo "Created force link at $HOME/.vimrc"
}

set_xfce() {
  mkdir -p $HOME/.config/xfce4/xfconf/xfce-perchannel-xml
  ln -sf $dotDirectory/xfconf/xfce-perchannel-xml/xfwm4.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
  echo "Created force link at $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"
  ln -sf $dotDirectory/xfconf/xfce-perchannel-xml/xsettings.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
  echo "Created force link at $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"
}

set_xmodmap() {
  ln -sf $dotDirectory/.Xmodmap $HOME/.Xmodmap
  echo "Created force link ar $HOME/.Xmodmap"
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

          e)  set_bash
              set_gtk
              set_font_config
              set_panel
              set_terminal
              set_vim
              set_vscode
              set_intellij
              set_keybinding
              set_xmodmap
              set_xfce
              ;;

          b)  set_bash
              ;;

          g)  set_gtk
              ;;

          f)  set_font_config
              ;;

          p)  set_panel
              ;;

          t)  set_terminal
              ;;

          v)  set_vim
              ;;

          c)  set_vscode
              ;;

          i)  set_intellij
              ;;

          k)  set_keybinding
              ;;

          m)  set_xmodmap
              ;;

          x)  set_xfce
              ;;

          *)
              show_help >&2
              exit 1
              ;;
      esac
  done
fi
