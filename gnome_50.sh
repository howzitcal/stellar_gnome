#!/bin/bash

DOWNLOAD_PATH="$HOME/.tmp_downloads"

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
echo "[/]
animate-appicon-hover=false
animate-appicon-hover-animation-extent={'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}
app-ctrl-hotkey-1=['<Control><Super>1']
app-ctrl-hotkey-10=['<Control><Super>0']
app-ctrl-hotkey-2=['<Control><Super>2']
app-ctrl-hotkey-3=['<Control><Super>3']
app-ctrl-hotkey-4=['<Control><Super>4']
app-ctrl-hotkey-5=['<Control><Super>5']
app-ctrl-hotkey-6=['<Control><Super>6']
app-ctrl-hotkey-7=['<Control><Super>7']
app-ctrl-hotkey-8=['<Control><Super>8']
app-ctrl-hotkey-9=['<Control><Super>9']
app-ctrl-hotkey-kp-1=['<Control><Super>KP_1']
app-ctrl-hotkey-kp-10=['<Control><Super>KP_0']
app-ctrl-hotkey-kp-2=['<Control><Super>KP_2']
app-ctrl-hotkey-kp-3=['<Control><Super>KP_3']
app-ctrl-hotkey-kp-4=['<Control><Super>KP_4']
app-ctrl-hotkey-kp-5=['<Control><Super>KP_5']
app-ctrl-hotkey-kp-6=['<Control><Super>KP_6']
app-ctrl-hotkey-kp-7=['<Control><Super>KP_7']
app-ctrl-hotkey-kp-8=['<Control><Super>KP_8']
app-ctrl-hotkey-kp-9=['<Control><Super>KP_9']
app-hotkey-1=['<Super>1']
app-hotkey-10=['<Super>0']
app-hotkey-2=['<Super>2']
app-hotkey-3=['<Super>3']
app-hotkey-4=['<Super>4']
app-hotkey-5=['<Super>5']
app-hotkey-6=['<Super>6']
app-hotkey-7=['<Super>7']
app-hotkey-8=['<Super>8']
app-hotkey-9=['<Super>9']
app-hotkey-kp-1=['<Super>KP_1']
app-hotkey-kp-10=['<Super>KP_0']
app-hotkey-kp-2=['<Super>KP_2']
app-hotkey-kp-3=['<Super>KP_3']
app-hotkey-kp-4=['<Super>KP_4']
app-hotkey-kp-5=['<Super>KP_5']
app-hotkey-kp-6=['<Super>KP_6']
app-hotkey-kp-7=['<Super>KP_7']
app-hotkey-kp-8=['<Super>KP_8']
app-hotkey-kp-9=['<Super>KP_9']
app-shift-hotkey-1=['<Shift><Super>1']
app-shift-hotkey-10=['<Shift><Super>0']
app-shift-hotkey-2=['<Shift><Super>2']
app-shift-hotkey-3=['<Shift><Super>3']
app-shift-hotkey-4=['<Shift><Super>4']
app-shift-hotkey-5=['<Shift><Super>5']
app-shift-hotkey-6=['<Shift><Super>6']
app-shift-hotkey-7=['<Shift><Super>7']
app-shift-hotkey-8=['<Shift><Super>8']
app-shift-hotkey-9=['<Shift><Super>9']
app-shift-hotkey-kp-1=['<Shift><Super>KP_1']
app-shift-hotkey-kp-10=['<Shift><Super>KP_0']
app-shift-hotkey-kp-2=['<Shift><Super>KP_2']
app-shift-hotkey-kp-3=['<Shift><Super>KP_3']
app-shift-hotkey-kp-4=['<Shift><Super>KP_4']
app-shift-hotkey-kp-5=['<Shift><Super>KP_5']
app-shift-hotkey-kp-6=['<Shift><Super>KP_6']
app-shift-hotkey-kp-7=['<Shift><Super>KP_7']
app-shift-hotkey-kp-8=['<Shift><Super>KP_8']
app-shift-hotkey-kp-9=['<Shift><Super>KP_9']
appicon-margin=0
appicon-padding=6
click-action='TOGGLE-SHOWPREVIEW'
dot-position='BOTTOM'
dot-style-focused='DOTS'
dot-style-unfocused='DOTS'
extension-version=73
focus-highlight-dominant=true
hotkeys-overlay-combo='TEMPORARILY'
intellihide=false
intellihide-key-toggle=['<Super>i']
multi-monitors=false
panel-anchors='{\"\":\"MIDDLE\"}'
panel-element-positions='{\"\": [{\"element\": \"activitiesButton\",\"visible\": false,\"position\": \"stackedTL\"},{\"element\": \"showAppsButton\",\"visible\": true,\"position\": \"stackedTL\"},{\"element\": \"taskbar\",\"visible\": true,\"position\": \"stackedTL\"},{\"element\": \"centerBox\",\"visible\": true,\"position\": \"stackedBR\"},{\"element\": \"rightBox\",\"visible\": true,\"position\": \"stackedBR\"},{\"element\": \"leftBox\",\"visible\": true,\"position\": \"stackedBR\"},{\"element\": \"systemMenu\",\"visible\": true,\"position\": \"stackedBR\"},{\"element\": \"dateMenu\",\"visible\": true,\"position\": \"stackedBR\"},{\"element\": \"desktopButton\",\"visible\": true,\"position\": \"stackedBR\"}]}'
panel-element-positions-monitors-sync=false
panel-lengths='{}'
panel-positions='{\"\":\"BOTTOM\"}'
panel-sizes='{}'
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