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

echo "Cloning repository to $TEMP_DIR..."
git clone "$REPO_URL" "$TEMP_DIR"

EXTENSION_DIR=~/.local/share/nautilus-python/extensions
mkdir -p "$EXTENSION_DIR"

echo "Contents of the cloned repository:"
ls -R "$TEMP_DIR"

echo "Attempting to copy extension..."
if [ -f "$TEMP_DIR/src/ubuntu/cpfubuntu.py" ]; then
    cp "$TEMP_DIR/src/ubuntu/cpfubuntu.py" "$EXTENSION_DIR/"
    echo "Copy successful."
else
    echo "Error: cpfubuntu.py not found in the repository."
fi

echo "Contents of the extension directory:"
ls "$EXTENSION_DIR"

# Cleanup
rm -rf "$TEMP_DIR"

# Set correct permissions
chmod +r "$EXTENSION_DIR/cpfubuntu.py"

# Restart Nautilus
echo "Restarting Nautilus..."
nautilus -q

echo "Installation complete. 'Copy Path to File' should now be available in the context menu."
