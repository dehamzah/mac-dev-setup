# 🍏 Mac Dev Setup

A collection of scripts and configurations to automate your macOS development environment setup. Perfect for fresh installs or setting up a new workstation quickly.

---

## 🚀 Quick Start

The fastest way to get your environment up and running:

### Option 1: Using git clone (Recommended)
```bash
git clone https://github.com/dehamzah/mac-dev-setup.git ~/mac-dev-setup
cd ~/mac-dev-setup
./install.sh
```

### Option 2: Direct Download
1.  [Download Zip](https://github.com/dehamzah/mac-dev-setup/archive/refs/heads/main.zip) and extract it.
2.  Open your terminal and navigate to the extracted folder.
3.  Run the installation script:
    ```bash
    ./install.sh
    ```

---

## ✨ Features

- **Homebrew Automation**: Installs Homebrew and all packages listed in `Brewfile`.
- **Runtime Management**: Uses [mise](https://mise.jdx.dev/) for seamless management of Node.js, Bun, Python, and Ruby.
- **Modern Terminal Experience**:
    - [Ghostty](https://ghostty.org/) as the default terminal.
    - [Starship](https://starship.rs/) for a lightning-fast prompted experience.
    - [fzf](https://github.com/junegunn/fzf) for fuzzy searching.
- **SSH & Git Configuration (If not exist)**:
    - Automatically generates a secure `ed25519` SSH key.
    - Configures global git settings including name, email, and default branch.
- **Containerization Support**: Ready-to-go setup for Docker (via Colima), Kubernetes (kubectl, helm), and k9s.

---

## 🛠️ What's Included?

### 📦 CLI Tools
- **Basics**: git, wget, curl, jq, vim, fzf.
- **Dev Tools**: mise, starship.

### 🐳 Containerization & K8s
- docker, docker-compose, colima, qemu.
- kubernetes-cli (kubectl), helm, krew, k9s.

### 🍱 Programming Runtimes (via mise)
- **Node.js**: lts version.
- **Bun**: latest version.
- **Python**: version 3.
- **Ruby**: version 3.

### 🖥️ Desktop Applications (Casks)
- **Browsers**: Google Chrome, Firefox, Dia.
- **Editors**: Visual Studio Code, Antigravity.
- **Utilities**: Bruno (API client), Stats, VLC, Keka.
- **Communication**: Zoom.

---

## ⚙️ Customization

This setup is designed to be easily extensible:

1.  **Modify Tool List**: Open `Brewfile` to add or remove tools/apps.
2.  **Adjust Runtimes**: Check `.config/mise/config.toml` to change preferred language versions.
3.  **Shell Settings**: Update `.zprofile` for path changes and environment variables.

---

## 🏁 Post-Installation

Once the script completes, please:
1.  **Restart your terminal** to apply all path changes and shell initializations.
2.  **Add your SSH Key to GitHub**:
    - The `install.sh` script will display your public key.
    - Copy it and go to [GitHub SSH Settings](https://github.com/settings/keys) to add it.
3.  **Log in to your accounts**: Sign in to VS Code, Chrome, etc., and sync your settings.

---

## 📄 License

This project is licensed under the [MIT License](LICENCE).