
# Create ROMS dir structure
mkdir -p ~/Documents/ROMS/Wii
mkdir -p ~/Documents/ROMS/GameCube
mkdir -p ~/Documents/ROMS/PS2
mkdir -p ~/Documents/ROMS/PS3
mkdir -p ~/Documents/ROMS/PSP
mkdir -p ~/Documents/ROMS/SNES


# Check if steam user has been logged in
#  If not, log in and close (try again if failed)
numSteamUsers=`ls ~/.steam/steam/userdata | wc -l`;
while [ "$numSteamUsers" -lt "1" ]
do
	# Open steam to login, and immediately close
	steam -nofriendsui -shutdown;
	sleep 3; # Give opportunity to kill script in case of loop (steam doesn't like CTRL-C)
	numSteamUsers=`ls ~/.steam/steam/userdata | wc -l`;
done


# Check if SteamRomManager has been initialized
#  If not, start and stop to populate config dir
set -m;
srmUserData=~/.config/steam-rom-manager/userData;
if [ ! -d "$srmUserData" ]; then
	echo "Steam Rom Manager first run...";
#	steam-rom-manager list;
#	timeout 10s steam-rom-manager list;
#	steam-rom-manager & pidsave="$!";
#	sleep 10;
#	kill $pidsave;
#	kill $pidsave $(pgrep -P $pidsave)
fi


# Configure SRM Variables
userHomePath='/home/lyndwil';
#userSettingsPath=~/.config/steam-rom-manager/userData/userSettings.json;
touch '$userSettingsPath';
userSettings=`jq '.environmentVariables.romsDirectory = $dir' --arg dir "$userHomePath/Documents/ROMS" "$srmUserData/userSettings.json"`;
echo "$userSettings" > "$srmUserData/userSettings.json";
userSettings=`jq '.environmentVariables.steamDirectory = $dir' --arg dir "$userHomePath/.steam/steam" "$srmUserData/userSettings.json"`;
echo "$userSettings" > "$srmUserData/userSettings.json";
userSettings=`jq '.environmentVariables.retroarchPath = $dir' --arg dir "$userHomePath/.local/bin/retroarch" "$srmUserData/userSettings.json"`;
echo "$userSettings" > "$srmUserData/userSettings.json";
userSettings=`jq '.environmentVariables.raCoresDirectory = $dir' --arg dir "/usr/lib/libretro" "$srmUserData/userSettings.json"`;
echo "$userSettings" > "$srmUserData/userSettings.json";



#steam-rom-manager add

#steam
