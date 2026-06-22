#!/bin/bash
set -e

# check if command exists
exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Starting installation..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg

# docker official repository setup and installation
if exists docker; then
    echo "Docker already installed"
else
    echo "Installing Docker CE..."
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# python 3.9+ check and specific installation
py_minor=$(python3 -c 'import sys; print(sys.version_info[1])' 2>/dev/null || echo 0)
if [ "$py_minor" -ge 9 ]; then
    echo "Python 3.9+ already installed"
else
    echo "Installing Python 3.9..."
    sudo apt-get install -y python3.9
fi

# django
if ! exists pip3; then
    echo "Installing pip..."
    sudo apt-get install -y python3-pip
fi

if python3 -m django --version >/dev/null 2>&1; then
    echo "Django already installed"
else
    echo "Installing Django..."
    pip3 install django
fi

echo "Done"
