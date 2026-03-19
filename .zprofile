# Homebrew environment setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Mise
eval "$(mise activate zsh)"

# Starship
eval "$(starship init zsh)"

# Krew plugin manager for kubectl setup
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
