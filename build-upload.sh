podman login
podman build -t docker.io/creator5280/vanilla-subsystem-aur-gaming:$1 --no-cache .
podman push docker.io/creator5280/vanilla-subsystem-aur-gaming:$1
