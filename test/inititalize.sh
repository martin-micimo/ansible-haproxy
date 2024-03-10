#!/bin/bash

# Install dependencies
sudo apt update
sudo apt -y install python3 python3-pip python3-venv ansible ca-certificates curl gnupg lsb-release apt-transport-https gpg rsync

# Check for docker and install it
DOCKER_CHECK=$(docker version|grep '^ Version.*'|wc -l)
if [[ $DOCKER_CHECK -ne 1 ]]; then
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" |sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
	sudo systemctl start docker
fi
# Install Molecule in special venv
python3 -m venv ansible-venv
source ansible-venv/bin/activate
cd ansible-venv/
pip3 install wheel molecule 'molecule-plugins[docker]' pytest-testinfra
echo "Development Environment is READY"
