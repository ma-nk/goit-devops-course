#!/bin/bash

# check if command exists
exists() {
  command -v "$1" >/dev/null 2>&1
}

echo "Starting installation..."
sudo apt-get update -y

# docker
if exists docker; then
    echo "Docker already installed"
else
    echo "Installing Docker..."
    sudo apt-get install -y docker.io
fi

# docker-compose
if exists docker-compose; then
    echo "Docker Compose already installed"
else
    echo "Installing Docker Compose..."
    sudo apt-get install -y docker-compose
fi

# python 3.9+
py_minor=$(python3 -c 'import sys; print(sys.version_info[1])' 2>/dev/null)
if exists python3 && [ "$py_minor" -ge 9 ]; then
    echo "Python 3.9+ already installed"
else
    echo "Installing Python 3..."
    sudo apt-get install -y python3
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
