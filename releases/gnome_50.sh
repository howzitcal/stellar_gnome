#!/bin/bash

DOWNLOAD_PATH="$HOME/.tmp_downloads"
mkdir $DOWNLOAD_PATH

echo "Start adding gnome extensions..."
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "AlphabeticalAppGrid@stuarthayhurst"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Always-Show-Titles-In-Overview@gmail.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "batterytimepercentagecompact@sagrland.de"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "caffeine@patapon.info"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "mute-unmute@mcast.gnomext.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "just-perfection-desktop@just-perfection"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "tiling-assistant@leleat-on-github"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "tophat@fflewddur.github.io"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "dynamic-music-pill@andbal"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "screencast.extra.feature@wissle.me"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "appindicatorsupport@rgcjonas.gmail.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "dash-to-panel@jderose9.github.com"

sleep 15

echo "Running customizations..."

# app indicators customizations
dconf write /org/gnome/shell/extensions/appindicator/icon-size 19
dconf write /org/gnome/shell/extensions/appindicator/tray-pos "'right'"

# remove all app menu folders and auto categories, we can sort our own apps, thanks!
gsettings reset org.gnome.desktop.app-folders folder-children
gsettings set org.gnome.desktop.app-folders folder-children "[]"

# remove all pinned apps
dconf write /org/gnome/shell/favorite-apps "['']"

# top hat customizations
dconf write /org/gnome/shell/extensions/tophat/show-disk false
dconf write /org/gnome/shell/extensions/tophat/show-fs false
dconf write /org/gnome/shell/extensions/tophat/show-net true
dconf write /org/gnome/shell/extensions/tophat/cpu-display "'numeric'"
dconf write /org/gnome/shell/extensions/tophat/cpu-sort-cores false
dconf write /org/gnome/shell/extensions/tophat/mem-display "'numeric'"
dconf write /org/gnome/shell/extensions/tophat/position-in-panel "'rightedge'"

# just perfection customizations
dconf write /org/gnome/shell/extensions/just-perfection/notification-banner-position 5

# adjust tiling customizations
dconf write /org/gnome/shell/extensions/tiling-assistant/enable-tiling-popup false

# install jetbrains font
mkdir -p $HOME/.local/share/fonts/jetbrains
wget https://github.com/howzitcal/stellar_gnome/raw/refs/heads/main/resources/gnome_50/jetbrains-fonts.tar -O $DOWNLOAD_PATH/jetbrains-fonts.tar
tar -xf $DOWNLOAD_PATH/jetbrains-fonts.tar -C $HOME/.local/share/fonts/jetbrains --wildcards "*.ttf"
fc-cache -f

# get wallpaper
mkdir -p $HOME/Pictures/wallpapers
wget https://github.com/howzitcal/stellar_gnome/raw/refs/heads/main/resources/gnome_50/window-to-the-world-desktop-image-only-1.png -O $HOME/Pictures/wallpapers/nasa-1.png

# caffine customizations
dconf write /org/gnome/shell/extensions/caffeine/show-indicator "'always'"
dconf write /org/gnome/shell/extensions/caffeine/enable-mpris false
dconf write /org/gnome/shell/extensions/caffeine/show-notifications false

# music pill customizations
dconf write /org/gnome/shell/extensions/dynamic-music-pill/visualizer-style 0
dconf write /org/gnome/shell/extensions/dynamic-music-pill/enable-transparency false
dconf write /org/gnome/shell/extensions/dynamic-music-pill/target-container 1
dconf write /org/gnome/shell/extensions/dynamic-music-pill/vertical-offset 0
dconf write /org/gnome/shell/extensions/dynamic-music-pill/panel-pill-height 42
dconf write /org/gnome/shell/extensions/dynamic-music-pill/popup-vinyl-square false
dconf write /org/gnome/shell/extensions/dynamic-music-pill/popup-follow-transparency false
dconf write /org/gnome/shell/extensions/dynamic-music-pill/enable-lyrics false
dconf write /org/gnome/shell/extensions/dynamic-music-pill/show-pill-border false
dconf write /org/gnome/shell/extensions/dynamic-music-pill/panel-art-size 26
dconf write /org/gnome/shell/extensions/dynamic-music-pill/popup-vinyl-rotate true

# gnome desktop customizations
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface monospace-font-name 'Jetbrains Mono 13'
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.background picture-uri-dark "file:///$HOME/Pictures/wallpapers/nasa-1.png"

# dash to panel customizations (lord have mercy!)
MONITORS=$(grep -P 'vendor|product|serial' ~/.config/monitors.xml | sed 's/<\/\?[^>]\+>//g; s/^[ \t]*//' | awk 'NR%3==1 {v=$0} NR%3==0 {print v "-" $0}' | sort -u)
ELEMENTS='[{"element": "activitiesButton","visible": false,"position": "stackedTL"},{"element": "showAppsButton","visible": true,"position": "stackedTL"},{"element": "taskbar","visible": true,"position": "stackedTL"},{"element": "centerBox","visible": true,"position": "stackedBR"},{"element": "rightBox","visible": true,"position": "stackedBR"},{"element": "leftBox","visible": true,"position": "stackedBR"},{"element": "systemMenu","visible": true,"position": "stackedBR"},{"element": "dateMenu","visible": true,"position": "stackedBR"},{"element": "desktopButton","visible": true,"position": "stackedBR"}]'
POSITIONS_JSON='{ "": '$ELEMENTS

for MON in $MONITORS; do
    POSITIONS_JSON+=', "'$MON'": '$ELEMENTS
done

POSITIONS_JSON+=' }'
FINAL_POSITIONS=$(echo $POSITIONS_JSON | sed 's/"/\\"/g')

echo "[/]
animate-appicon-hover=false
animate-appicon-hover-animation-extent={'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}
appicon-margin=0
appicon-padding=6
click-action='TOGGLE-SHOWPREVIEW'
dot-position='BOTTOM'
dot-style-focused='DOTS'
dot-style-unfocused='DOTS'
focus-highlight-dominant=true
hotkeys-overlay-combo='TEMPORARILY'
intellihide=false
intellihide-key-toggle=['<Super>i']
multi-monitors=false
panel-anchors='{\"\":\"MIDDLE\"}'
panel-element-positions='$FINAL_POSITIONS'
panel-element-positions-monitors-sync=false
panel-lengths='{}'
panel-positions='{\"\":\"BOTTOM\"}'
panel-sizes='{}'
hot-keys=true
prefs-opened=false
hide-overview-on-startup=true
primary-monitor=''
shortcut=['<Super>q']
stockgs-force-hotcorner=true
trans-border-use-custom-color=false
trans-border-width=1
trans-panel-opacity=0.97999999999999998
trans-use-border=false
trans-use-custom-bg=false
trans-use-custom-gradient=false
trans-use-custom-opacity=true
window-preview-title-position='TOP'
" > ./tmp_panel.conf
dconf load /org/gnome/shell/extensions/dash-to-panel/ < ./tmp_panel.conf
rm ./tmp_panel.conf

echo "Cleaning up..."
rm -rf $DOWNLOAD_PATH

echo -e "\n\n===\nComplete!"