# Dotfiles

Run `script/bootstrap`

export ZSH=$HOME/Bukephalos/dotfiles

# Set macOS defaults
$ZSH/macos/set-defaults.sh

# Install homebrew
$ZSH/homebrew/install.sh 2>&1

# Upgrade homebrew
echo "› brew update"
brew update

# Install software
echo "› $ZSH/script/install"
$ZSH/script/install
