#!/bin/bash

echo "Starting development environment setup..."

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed..."
fi

# Define the desired ZSH theme
DESIRED_ZSH_THEME="avit"

# Check if ZSH theme is already set to the desired theme
if ! grep -q "ZSH_THEME=\"$DESIRED_ZSH_THEME\"" ~/.zshrc; then
    echo "Setting ZSH theme to '$DESIRED_ZSH_THEME'..."
    sed -i '' "s/^ZSH_THEME=\".*\"/ZSH_THEME=\"$DESIRED_ZSH_THEME\"/" ~/.zshrc
else
    echo "ZSH theme is already set to '$DESIRED_ZSH_THEME'..."
fi
    
# Check if Homebrew is installed
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed..."
fi

# Update Homebrew recipes
echo "Updating Homebrew..."
brew update

# Additional Brew Registries
brew tap oven-sh/bun

# Install all dependencies from Brewfile
echo "Installing dependencies from Brewfile..."
brew bundle

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