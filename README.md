# Dean's Dotfiles

These are my personal configuration files (dotfiles) to set up my development environment across different machines. The setup uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management to keep everything modular and easy to update.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Directory Structure](#directory-structure)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository contains configuration files for various development tools and applications I use on a day-to-day basis. The configuration is modularized by application, allowing for easier maintenance and portability.

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

2. **Install GNU Stow**:

    If you don’t have GNU Stow installed, you can install it using a package manager:

    - **macOS**: 
      ```bash
      brew install stow
      ```
    - **Linux** (Debian/Ubuntu):
      ```bash
      sudo apt install stow
      ```

3. **Run Stow**:

    Use `stow` to create symlinks for the configuration files you want to use. For example, to set up your shell, git, and tmux configurations:

    ```bash
    stow shell
    stow git
    stow .config/tmux
    ```

    This will automatically create symlinks from your `~/.dotfiles` directory to the appropriate locations in your home directory.

## Directory Structure

The repository is structured to keep configurations for different tools in their respective directories. Here's an overview of the structure:

```plaintext
.dotfiles/
├── .config/
│   ├── tmux/
│   │   └── tmux.conf         # Tmux configuration
│   └── other-app/            # Additional application configs (e.g., Neovim, Kitty)
├── git/
│   └── gitconfig             # Git configuration
├── shell/
│   ├── bash_profile          # Bash profile for shell initialization
│   ├── zshrc                 # Zsh configuration
│   └── zprofile              # Zsh profile for shell initialization
├── .gitignore                # Git ignore file for the dotfiles repo
└── README.md                 # Documentation for setting up the environment