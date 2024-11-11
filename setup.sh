# Variables
USER="spiderunderurbed"
DIR="acer-predator-turbo-and-rgb-keyboard-linux-module"
SOURCE_FOLDER="./spiderunderurbed"  # Folder to move items from

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
if [ -d "/home/$USER/home-manager" ]; then  
    echo "/home/$USER/home-manager directory already exists."
else 
    echo "Directory '/home/$USER/home-manager' does not exist. Creating it..."
    mkdir -p "/home/$USER/home-manager"
fi

#Download python extention
#Download the sober flatpakref

ln -s /etc/nixos/hyprland.conf /etc/nixos/spiderunderurbed/hyprland.conf
