```markdown
# Dean's Dotfiles

This repository contains my personal configuration files (dotfiles) for tools like Zsh, Tmux, Kitty, Neovim, and more. These dotfiles are organized to be symlinked to their correct locations using `stow` for easier management and version control.

## Structure

The repository is structured as follows:

```bash
~/.dotfiles/
├── .git/                # Git repository metadata
├── .gitignore           # Files to ignore in Git (e.g., .DS_Store)
├── .stow-local-ignore   # Ignore certain files in stow operations
├── btop/                # Btop configuration files
├── git/                 # Global Git configuration
├── kitty/               # Kitty terminal configuration
├── lazygit/             # Lazygit configuration
├── nvim/                # Neovim configuration
├── oh-my-zsh/           # Oh My Zsh framework and custom themes
├── shell/               # Zsh configuration (e.g., .zshrc, .zprofile)
├── tmux/                # Tmux configuration
├── vscode/              # VSCode configuration
└── README.md            # This README file
```

## Setup Instructions

### 1. Clone the Repository

First, clone the repository into your home directory:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

### 2. Install `stow`

This repository uses `stow` to manage symlinks. Install it using Homebrew:

```bash
brew install stow
```

### 3. Symlink Dotfiles Using `stow`

Once `stow` is installed, navigate to the `.dotfiles` directory and use `stow` to symlink the dotfiles to the appropriate locations in your system:

```bash
cd ~/.dotfiles

# Symlink each component:
stow --target=$HOME btop
stow --target=$HOME git
stow --target=$HOME kitty
stow --target=$HOME lazygit
stow --target=$HOME nvim
stow --target=$HOME oh-my-zsh
stow --target=$HOME shell
stow --target=$HOME tmux
stow --target=$HOME vscode
```

### 4. Reload Zsh Configuration

After creating the symlinks, reload Zsh to apply the changes:

```bash
source ~/.zshrc
```

### 5. Configure Tmux Plugins

If you are using Tmux, run the following command inside a Tmux session to install all Tmux plugins using TPM (Tmux Plugin Manager):

```bash
# Press `Ctrl + Space` and then `I` to install the Tmux plugins.
```

### 6. macOS Setup

For macOS users, this repository includes a `setup_mac.sh` script to automate setting up your macOS environment, installing essential tools and configuring system settings.

To run the macOS setup script:

```bash
~/.dotfiles/setup_mac.sh
```

This script will:
- Install Homebrew and essential development tools like Git, Tmux, Neovim, Node.js, and Yarn.
- Configure macOS preferences such as keyboard repeat rate, tap-to-click, and showing hidden files in Finder.

### Key Configurations

#### Zsh (Oh My Zsh)

- Located in: `~/.dotfiles/shell/.zshrc`
- Custom theme: **headline** (located in `~/.oh-my-zsh/custom/themes`)
- Includes aliases and environment variables for managing development tools (like NVM, PNPM, Bun)

#### Tmux

- Located in: `~/.dotfiles/tmux/tmux.conf`
- Uses several plugins managed via TPM, including `tmux-resurrect`, `tmux-sessionx`, and more
- Keybindings for resizing panes, Vim-aware navigation, and toggling the status bar

#### Kitty

- Located in: `~/.dotfiles/kitty/kitty.conf`
- Configures the **Tokyo Night** theme for Kitty and includes custom keybindings for natural text navigation
- Enables mouse support and clipboard integration

#### Neovim

- Located in: `~/.dotfiles/nvim/init.lua`
- Configures Neovim for a modern development environment with custom plugins

#### Git

- Located in: `~/.dotfiles/git/.gitconfig`
- Includes global Git configuration for user details and default branch setup

### Updating Dotfiles

To update your dotfiles after making changes, commit and push them to GitHub:

```bash
git add .
git commit -m "Update dotfiles"
git push origin main
```

## License

This repository is for personal use. Feel free to fork it or use it as inspiration for your own dotfiles, but there is no warranty or official support.
