# #!/bin/bash

echo "Starting the installation process..."

# Update package lists
sudo apt update

# Install C++ and build-essential 
echo "Installing C++ and build-essential..."
sudo apt install -y g++ build-essential

# Install CMake 
echo "Installing CMake..."
sudo apt install -y cmake

# Install curl 
echo "Installing curl..."
sudo apt install -y curl

# Install Python3 and pip 
echo "Installing Python3 and pip..."
sudo apt install -y python3 python3-pip

# Install Tkinter 
echo "Installing Tkinter..."
sudo apt install -y python3-tk

# Install jq 
echo "Installing jq..."
sudo apt install -y jq

# Install Shell Script tools 
echo "Installing Shell script tools..."
sudo apt install -y bash


echo "Making all .sh files in ./scripts/ executable..."

chmod +x "run.sh"
for script in ./scripts/*.sh; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        echo "Made $script executable."
    fi
done

echo "------------------------------------"
echo "Installation done "
echo "------------------------------------"
exit 0
