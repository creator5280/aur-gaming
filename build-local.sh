

# Build source image
podman build -t docker.io/creator5280/vanilla-aur-gaming:latest $1 .;


# Remove existing aurg stack
if [[ $(apx subsystems list) == *"┊ aurg "* ]]; then
#	apx aurg unexport --bin /usr/sbin/steam;
	apx subsystems rm -f -n aurg;
fi


# Remove existing aur-gaming stack
if [[ $(apx stacks list) == *"┊ aur-gaming "* ]]; then
	apx stacks rm -f -n aur-gaming;
fi


# Remove existing yay pkgmanager
if [[ $(apx pkgmanagers list) == *"┊ yay "* ]]; then
        apx pkgmanagers rm -f -n yay;
fi


# Remove application and game files
sudo rm -r ~/.local/share/Steam
sudo rm -r ~/.config/steam-rom-manager
sudo rm -r ~/.config/retroarch
sudo rm -r ~/.steam


# Configure yay pkgmanager
apx pkgmanagers new\
 --name 'yay'\
 --need-sudo false\
 --install '-S'\
 --search '-Ss'\
 --clean '-Sc'\
 --purge '-Rns'\
 --remove '-R'\
 --autoremove '-Yc'\
 --list '-Pc'\
 --show '-Ps'\
 --update '-Sy'\
 --upgrade '-Syu';


# Configure aur-gaming stack
apx stacks new\
 --name 'aur-gaming'\
 --base 'docker.io/creator5280/vanilla-aur-gaming:latest'\
 --pkg-manager 'yay'\
 --packages 'nano';


# Configure aurg subsystem
apx subsystems new\
 --name 'aurg'\
 --stack 'aur-gaming';

# Export binaries
apx aurg export --bin /usr/sbin/steam;
apx aurg export --bin /usr/sbin/retroarch;
apx aurg export --bin /usr/sbin/dolphin-emu;
apx aurg export --bin /usr/local/bin/steam-rom-manager;


#apx subsystems new -n aurg -s aur-gaming
