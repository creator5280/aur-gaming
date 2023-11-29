mkdir -p ~/Documents/ROMS/Wii
mkdir -p ~/Documents/ROMS/GameCube
mkdir -p ~/Documents/ROMS/PS2
mkdir -p ~/Documents/ROMS/PS3
mkdir -p ~/Documents/ROMS/PSP
mkdir -p ~/Documents/ROMS/SNES

steam

mkdir -p ~/.config/retroarch
mkdir -p ~/.config/steam-rom-manager/userData/
mkdir -p ~/.config/retroarch/system/dolphin-emu
cp -r /var/containerFiles/steam/userdata/userid/config/* ~/.steam/steam/userdata/*/config/
cp /var/containerFiles/steam-rom-manager/userData/* ~/.config/steam-rom-manager/userData/
cp /var/containerFiles/retroArch/* ~/.config/retroarch/
ln -s /var/containerFiles/retroArch/dolphin/Data/Sys ~/.config/retroarch/system/dolphin-emu/Sys
steam-rom-manager add

steam
