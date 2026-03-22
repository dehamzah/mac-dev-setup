#!/bin/bash

echo "Starting development environment setup..."

 
# Check if Homebrew is installed
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed..."
fi

# Update Homebrew recipes
read -p "Update Homebrew recipes? (y/n): " update_brew
if [[ $update_brew == "y" || $update_brew == "Y" ]]; then
    echo "Updating Homebrew..."
    brew update
else
    echo "Skipping Homebrew update..."
fi

# Install all dependencies from Brewfile
echo "Installing dependencies from Brewfile..."
brew bundle



# Copy mise config
echo "Configuring mise..."
MISE_CONFIG_HOME="$HOME/.config/mise/config.toml"
MISE_CONFIG_DIR="$HOME/.config/mise"
# The script is expected to be run from the repository root
REPO_MISE_CONFIG=".config/mise/config.toml"

if [ ! -d "$MISE_CONFIG_DIR" ]; then
    mkdir -p "$MISE_CONFIG_DIR"
fi

if [ ! -f "$MISE_CONFIG_HOME" ]; then
    echo "Copying mise config to $MISE_CONFIG_HOME..."
    cp "$REPO_MISE_CONFIG" "$MISE_CONFIG_HOME"
else
    read -p "Mise config already exists in $MISE_CONFIG_HOME. Overwrite it? (y/n): " overwrite
    if [[ $overwrite == "y" || $overwrite == "Y" ]]; then
        echo "Overwriting mise config..."
        cp "$REPO_MISE_CONFIG" "$MISE_CONFIG_HOME"
    else
        echo "Skipping mise config copy..."
    fi
fi

# Setup mise
echo "Setting up mise..."
mise install

# Configure .zshrc
echo "Configuring .zshrc..."
ZSHRC_HOME="$HOME/.zshrc"
REPO_ZSHRC=".zshrc"
MARKER="# BEGIN MAC-DEV-SETUP"

if [ -f "$ZSHRC_HOME" ]; then
    if grep -q "$MARKER" "$ZSHRC_HOME"; then
        echo ".zshrc already contains mac-dev-setup configuration. Skipping..."
    else
        echo "Appending mac-dev-setup configuration to $ZSHRC_HOME..."
        printf "\n" >> "$ZSHRC_HOME"
        cat "$REPO_ZSHRC" >> "$ZSHRC_HOME"
    fi
else
    echo "Creating $ZSHRC_HOME with mac-dev-setup configuration..."
    cp "$REPO_ZSHRC" "$ZSHRC_HOME"
fi

# Setup SSH key for GitHub
echo "Checking SSH key setup..."
SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "No SSH key found. Setting up new SSH key..."
    read -p "Enter your email for SSH key: " ssh_email
    ssh-keygen -t ed25519 -C "$ssh_email" -f "$SSH_KEY_PATH" -N ""
    
    # Start ssh-agent and add key
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_PATH"
    
    # Display the public key and instructions
    echo "\nYour SSH public key is:"
    cat "${SSH_KEY_PATH}.pub"
    echo "\nPlease add this SSH key to your GitHub account:"
    echo "1. Go to GitHub Settings -> SSH and GPG keys -> New SSH key"
    echo "2. Copy the above public key and paste it there"
    echo "3. Click 'Add SSH key'\n"
else
    echo "SSH key already exists at $SSH_KEY_PATH"
fi

# Setup git configuration
echo "Setting up git configuration..."
# Prompt for git user.name and user.email if not already set
if ! git config --global user.name >/dev/null; then
    read -p "Enter your Git user name: " git_user_name
    git config --global user.name "$git_user_name"
else
    echo "Git user.name is already set to '$(git config --global user.name)'..."
fi

if ! git config --global user.email >/dev/null; then
    read -p "Enter your Git user email: " git_user_email
    git config --global user.email "$git_user_email"
else
    echo "Git user.email is already set to '$(git config --global user.email)'..."
fi
git config --global init.defaultBranch main
git config --global core.editor "vim"

echo "Installation completed! 🎉"
echo "Please restart your terminal to ensure all changes take effect."