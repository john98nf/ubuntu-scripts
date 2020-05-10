#!/usr/bin/env bash
# -------------------------------------------------------
# Script to configure GnomeShell environment 
#   for Focal 20.04 LTS
#
# 10/05/2020, V1.0 - Migrate from Bionic
# -------------------------------------------------------

# install gnome shell extensions
logger "gnome-shell - gnome shell extensions"
sudo apt -y install gnome-shell-extensions

# install gnome sushi (space bar preview) 
logger "gnome-shell - gnome sushi"
sudo apt -y install gnome-sushi

# enable activities hot corner
logger "gnome-shell - top bar and hot corner"
gsettings set org.gnome.desktop.interface enable-hot-corners true

# hide hidden files by default
logger "gnome-shell - hidden files"
gsettings set org.gtk.Settings.FileChooser show-hidden false

# move dash to dock bottom and change look & feel
logger "gnome-shell - dash-to-dock options"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0

# enable middle and right click on lower area
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'

# gnome shell window bar icons
logger "gnome-shell - gnome shell window bar icons"
gsettings set org.gnome.desktop.wm.preferences button-layout :minimize,maximize,close

# enable icons for buttons and for menus
logger "gnome-shell - enable icons for buttons and for menus"
gsettings set org.gnome.desktop.interface buttons-have-icons true
gsettings set org.gnome.desktop.interface menus-have-icons true
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

# nautilus : remove nautilus action root menu
logger "gnome-shell - remove nautilus action root menu"
echo "[runtime]" >> $HOME/.config/filemanager-actions/filemanager-actions.conf
echo "items-create-root-menu=false" >> $HOME/.config/filemanager-actions/filemanager-actions.conf

# nautilus : declare new document templates
logger "gnome-shell - declare new document templates"
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-template-install.sh
if [ -f ./nautilus-template-install.sh ]
then 
  chmod +x ./nautilus-template-install.sh
  ./nautilus-template-install.sh
  rm ./nautilus-template-install.sh
fi

# nautilus : APK extensions
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-apk-install.sh
if [ -f ./nautilus-apk-install.sh ]
then 
  chmod +x ./nautilus-apk-install.sh
  ./nautilus-apk-install.sh
  rm ./nautilus-apk-install.sh
fi

# nautilus : EXIF tags extensions
wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/nautilus/nautilus-exif-install.sh
if [ -f ./nautilus-exif-install.sh ]
then 
  chmod +x ./nautilus-exif-install.sh
  ./nautilus-exif-install.sh
  rm ./nautilus-exif-install.sh
fi

# gnomeshell extensions - console management
logger "gnome-shell - console management of gnomeshell extensions"
sudo wget -O /usr/local/bin/gnomeshell-extension-manage https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage
sudo chmod +x /usr/local/bin/gnomeshell-extension-manage

# gnomeshell extensions - default extensions
logger "gnome-shell - default extensions"
# Extensions : enable/disable easily gnome shell extensions from a menu in the top panel
gnomeshell-extension-manage --install --user --extension-id 1036 --version latest
# OpenWeather : display weather information from https://openweathermap.org/
gnomeshell-extension-manage --install --user --extension-id 750 --version latest
# Sound Input & Output Device Chooser : shows a list of sound output and input devices in the status menu below the volume slider
gnomeshell-extension-manage --install --user --extension-id 906 --version latest
# Refresh Wifi Connections : adds a refresh button to the Wifi connection selection dialog
gnomeshell-extension-manage --install --user --extension-id 905 --version latest
