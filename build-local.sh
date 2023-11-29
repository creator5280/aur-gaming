apx subsystems rm -n aurg

#sudo rm -r ~/.local/share/Steam
sudo rm -r ~/.config/steam-rom-manager
sudo rm -r ~/.config/retroarch
sudo rm -r ~/.steam

podman build -t docker.io/creator5280/vanilla-subsystem-aur-gaming:latest $1 .

apx subsystems new -n aurg -s aur-gaming
