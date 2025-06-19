# Mac Dev Setup

This project provides a set of scripts and a Brewfile to automate the setup of a full-stack web development environment on a macOS machine.

## Installation

To get started, run the installation script:

```
./install.sh
```

This script will check if Homebrew is installed on your system. If it is not installed, the script will install Homebrew for you. After that, it will read the Brewfile and install the specified software packages.

It also install [oh my zsh](https://ohmyz.sh/) and setup the theme to 'avit'.

## Brewfile

The Brewfile contains a list of all the software packages and dependencies that are relevant for full-stack web development. You can modify this file to add or remove packages as needed.

## License

MIT