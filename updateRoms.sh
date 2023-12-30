mkdir -p ~/Documents/ROMS/Wii
mkdir -p ~/Documents/ROMS/GameCube
mkdir -p ~/Documents/ROMS/PS2
mkdir -p ~/Documents/ROMS/PS3
mkdir -p ~/Documents/ROMS/PSP
mkdir -p ~/Documents/ROMS/SNES

#steam

mkdir -p ~/.config/retroarch
mkdir -p ~/.config/steam-rom-manager/userData/

userHomePath='/home/lyndwil'
echo "$userHomePath"
userSettingsPath=~/.config/steam-rom-manager/userData/userSettings.json;
userSettings=`jq '.environmentVariables.romsDirectory = $dir' --arg dir "$userHomePath/Documents/ROMS" "$userSettingsPath"`;
echo "$userSettings" > "$userSettingsPath";
userSettings=`jq '.environmentVariables.steamDirectory = $dir' --arg dir "$userHomePath/.steam/steam" "$userSettingsPath"`;
echo "$userSettings" > "$userSettingsPath";
userSettings=`jq '.environmentVariables.retroarchPath = $dir' --arg dir "$userHomePath/.local/bin/retroarch" "$userSettingsPath"`;
echo "$userSettings" > "$userSettingsPath";

#mkdir -p ~/.config/retroarch/system/dolphin-emu
#cp -r /var/containerFiles/steam/userdata/userid/config/* ~/.steam/steam/userdata/*/config/
#cp /var/containerFiles/steam-rom-manager/userData/* ~/.config/steam-rom-manager/userData/
#cp /var/containerFiles/retroArch/* ~/.config/retroarch/
#ln -s /var/containerFiles/retroArch/dolphin/Data/Sys ~/.config/retroarch/system/dolphin-emu/Sys
#steam-rom-manager add

#steam
