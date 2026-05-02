#!/usr/bin/env bash

set -euo pipefail

# ── Xcode CLI Tools ────────────────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 5; done
fi

# ── Homebrew ───────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Brewfile ───────────────────────────────────────────────────────────────────
echo "Installing packages from Brewfile..."
brew bundle --file=./Brewfile

# ── Zap (ZSH plugin manager) ───────────────────────────────────────────────────
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/zap" ]]; then
  echo "Installing Zap..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
  rm -f ~/.zshrc  # stow will manage this
fi

# ── Dotfiles (GNU Stow) ────────────────────────────────────────────────────────
echo "Symlinking dotfiles..."
stow --target="$HOME" --dir=./dotfiles zsh vim nvim aerospace tmux ghostty swiftbar

# ── SwiftBar ───────────────────────────────────────────────────────────────────
chmod +x "$HOME/Library/Application Support/SwiftBar/Plugins/spaces.sh" 2>/dev/null || true
# Point SwiftBar at the stowed plugin directory
defaults write com.ameba.SwiftBar PluginDirectory "$HOME/Library/Application Support/SwiftBar/Plugins"

# ── Services ───────────────────────────────────────────────────────────────────
brew services start borders 2>/dev/null || true

# ── Launch GUI apps ────────────────────────────────────────────────────────────
open -a AeroSpace  2>/dev/null || true
open -a SwiftBar   2>/dev/null || true

echo ""
echo "Done. Restart your terminal or run: exec zsh -l"
