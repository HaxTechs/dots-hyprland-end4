# This script is meant to be sourced.
# It's not for directly running.

#####################################################################################
# These python packages are installed using uv into the venv (virtual environment). Once the folder of the venv gets deleted, they are all gone cleanly. So it's considered as setups, not dependencies.
showfun install-python-packages
v install-python-packages

if [[ -z $(getent group i2c) ]]; then
	v sudo groupadd i2c
fi

v sudo usermod -aG video,i2c,input "$(whoami)"

if [[ ! -z $(systemctl --version) ]]; then
	v bash -c "echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf"
	v systemctl --user enable ydotool --now
	v sudo systemctl enable bluetooth --now
elif [[ ! -z $(openrc --version) ]]; then
	v bash -c "echo 'modules=i2c-dev' | sudo tee -a /etc/conf.d/modules"
	v sudo rc-update add modules boot
	v sudo rc-update add ydotool default
	v sudo rc-update add bluetooth default
	
	x sudo rc-service ydotool start
	x sudo rc-service bluetooth start
else
	printf "${STY_RED}"
	printf "====================INIT SYSTEM NOT FOUND====================\n"
	printf "${STY_RST}"
	pause
fi

v sudo chown -R $(whoami):$(whoami) ~/.config/hypr/
v sudo chown -R $(whoami):$(whoami) ~/.config/quickshell/

v gsettings set org.gnome.desktop.interface font-name 'Rubik 11'
v gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
v kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle Darkly

# Setup SDDM and theme
v sudo mkdir -p /usr/share/sddm/themes/
v sudo cp -r "${base}/Extras/lunarSDDM" /usr/share/sddm/themes/
v sudo mkdir -p /etc/sddm.conf.d
v echo "[Theme]
Current=lunarSDDM" | sudo tee /etc/sddm.conf.d/theme.conf

# Enable SDDM service based on init system
if [[ ! -z $(systemctl --version) ]]; then
    v sudo systemctl enable sddm.service
elif [[ ! -z $(openrc --version) ]]; then
    v sudo rc-update add display-manager default
    v echo "DISPLAYMANAGER=\"sddm\"" | sudo tee /etc/conf.d/display-manager
    x sudo rc-service display-manager start
else
    printf "${STY_RED}"
    printf "====================INIT SYSTEM NOT FOUND====================\n"
    printf "SDDM service could not be enabled automatically.\n"
    printf "${STY_RESET}"
    pause
fi
