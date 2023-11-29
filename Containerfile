FROM docker.io/library/archlinux:latest

# Install make packages
RUN pacman -Syu --noconfirm && pacman -S --noconfirm base-devel git;

# Create Builder User
RUN useradd -m -G wheel builder && passwd -d builder; \
	echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;

# Install Yay
RUN mkdir -p /tmp/yay-build; \
	chown -R builder:builder /tmp/yay-build; \
	su - builder -c "git clone https://aur.archlinux.org/yay.git /tmp/yay-build/yay"; \
	su - builder -c "cd /tmp/yay-build/yay && makepkg -si --noconfirm"; \
	rm -rf /tmp/yay-build;

# Install and Configure Steam
RUN echo "[multilib]" >> /etc/pacman.conf && \
	echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf; \
	pacman -Sy; \
	yay -S --noconfirm steam; \
	mkdir -p /var/containerFiles/steam/userdata/userid/config;
COPY steam/userdata/userid/config/shortcuts.vdf /var/containerFiles/steam/userdata/userid/config/

# Install and Configure RetroArch
RUN yay -S --noconfirm retroarch \
	retroarch-assets-ozone \
	retroarch-assets-xmb \
	libretro-beetle-psx \
	libretro-snes9x \
	libretro-citra \
#	libretro-dolphin \ # Removed in favor of standalone, due to better controller support
	libretro-ppsspp \
	libretro-play \
	wget; \
	mkdir -p /var/containerFiles/retroArch; \
	cd /var/containerFiles/retroArch; \
	git clone --depth=1 https://github.com/libretro/dolphin.git;
COPY retroArch/* /var/containerFiles/retroArch/

# Install and Configure RPCS3
RUN yay -S --noconfirm fuse2; \
	wget -P /var/containerFiles/appimages/ --content-disposition https://rpcs3.net/latest-appimage; \
	ln -s /var/containerFiles/appimages/rpcs3*.AppImage /usr/local/bin/rpcs3;

# Install and Configure Steam Rom Manager
RUN wget -P /var/containerFiles/appimages/ --content-disposition https://github.com/SteamGridDB/steam-rom-manager/releases/download/v2.4.17/Steam-ROM-Manager-2.4.17.AppImage; \
	ln -s /var/containerFiles/appimages/Steam-ROM-Manager*.AppImage /usr/local/bin/steam-rom-manager; \
	chmod +x /usr/local/bin/*; \
	mkdir -p /var/containerFiles/steam-rom-manager/userData;
COPY steam-rom-manager/userData/user* /var/containerFiles/steam-rom-manager/userData/
