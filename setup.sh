# Variables
USER="spiderunderurbed"
DIR="acer-predator-turbo-and-rgb-keyboard-linux-module"
SOURCE_FOLDER="./spiderunderurbed"  # Folder to move items from
HOME_DIR="home-manager"
UUID=$(id -u spiderunderurbed)
# Check if the directory exists
if [ -d "$DIR" ]; then 
    echo "Directory '$DIR' already exists."
else
    echo "Directory '$DIR' does not exist. Cloning repository..."
    git clone https://github.com/JafarAkhondali/acer-predator-turbo-and-rgb-keyboard-linux-module
fi

# Check if the source folder exists and has files
if [ -d "$SOURCE_FOLDER" ]; then
    if [ "$(ls -A "$SOURCE_FOLDER")" ]; then  # Check if directory is not empty
        echo "Moving files from '$SOURCE_FOLDER' to /home/$USER/"
        mv "$SOURCE_FOLDER"/* "/home/$USER/"  
    else
        echo "Source folder '$SOURCE_FOLDER' is empty. No files to move."
    fi
else
    echo "Source folder '$SOURCE_FOLDER' does not exist."
fi

# Check if the /home/$USER directory exists
if [ ! -d "/home/$USER/$HOME_DIR" ] || [ ! "$(ls -A /home/$USER/$HOME_DIR)" ]; then
    echo "Directory '/home/$USER/$HOME_DIR' does not exist or is empty. Cloning and moving files..."
    mkdir -p "/home/$USER/$HOME_DIR"
    git clone https://github.com/SpiderUnderUrBed/home-manager.git /home/$USER/$HOME_DIR/home-manager
    mv /home/$USER/$HOME_DIR/home-manager/* /home/$USER/$HOME_DIR/
    rm -rf /home/$USER/$HOME_DIR/home-manager
else
    echo "/home/$USER/$HOME_DIR directory exists and is not empty. Skipping creation and cloning."
fi

#cd /etc/nixos

#Download python extention
#Download the sober flatpakref
#ln -s /home/nixos/spiderunderurbed/home-manager/ /etc/nixos/spiderunderurbed/
ln -s /home/$USER/$HOME_DIR /etc/nixos/$USER
ln -s /etc/nixos/hyprland.conf /etc/nixos/$USER/hyprland.conf
ln -s /etc/nixos/hyprland.nix /etc/nixos/$USER/hyprland.nix

chown -R spiderunderurbed:users /etc/nixos/spiderunderurbed/
#chmod $UUID /etc/nixos/spiderunderurbed/
chmod 705 /etc/nixos/spiderunderurbed/*
