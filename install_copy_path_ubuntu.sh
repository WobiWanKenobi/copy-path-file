#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Dependencies
if ! command_exists python3; then
    echo "Python is not installed. Installing..."
    sudo apt update
    sudo apt install -y python3
fi

if ! command_exists pip3; then
    echo "pip3 is not installed. Installing..."
    sudo apt install -y python3-pip
fi

if ! dpkg -s python3-nautilus >/dev/null 2>&1; then
    echo "python3-nautilus is not installed. Installing..."
    sudo apt install -y python3-nautilus
fi

if ! dpkg -s python3-gi >/dev/null 2>&1; then
    echo "python3-gi is not installed. Installing..."
    sudo apt install -y python3-gi
fi

if ! command_exists xclip; then
    echo "xclip is not installed. Installing..."
    sudo apt install -y xclip
fi

REPO_URL="https://github.com/WobiWanKenobi/copy-path-file"
TEMP_DIR=$(mktemp -d)

echo "Cloning repository..."
git clone "$REPO_URL" "$TEMP_DIR"

EXTENSION_DIR=~/.local/share/nautilus-python/extensions
mkdir -p "$EXTENSION_DIR"

echo "Copying extension..."
cp "$TEMP_DIR/copy_path_extension.py" "$EXTENSION_DIR/"

# Cleanup
rm -rf "$TEMP_DIR"

# Restart Nautilus
echo "Restarting Nautilus..."
nautilus -q

echo "Installation complete. 'Copy Path to File' should now be available in the context menu."
