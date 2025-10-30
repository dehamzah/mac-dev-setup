# Homebrew environment setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM (Node Version Manager) setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Krew plugin manager for kubectl setup
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"