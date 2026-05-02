# MacAutoSetup

Opinionated macOS dev environment. One script, fully automated.

## What's included

| Tool | Role |
|---|---|
| **AeroSpace** | Tiling window manager (i3-style) |
| **JankyBorders** | Window border highlights (active/inactive) |
| **SwiftBar** | Workspace indicator in the native macOS menu bar |
| **Ghostty** | Terminal |
| **AstroNvim** | Neovim IDE |
| **tmux** | Terminal multiplexer |
| **Zsh + Zap** | Shell + plugin manager |
| **Starship** | Shell prompt |
| **Raycast** | App launcher |
| **Brave Browser** | Browser |
| **VS Code** | GUI editor |
| **Discord** | Chat |
| **Shottr** | Screenshots |
| **Caffeine** | Prevent sleep |

### CLI tools

`git` `fzf` `ripgrep` `bat` `eza` `lazygit` `lazysql` `gh` `delta` `jq` `yq` `zoxide` `direnv` `starship` `awscli`

### GNU utilities (replaces macOS BSD defaults)

`coreutils` `gnu-sed` `findutils` `gawk`

### Font

JetBrains Mono Nerd Font

## Install

```sh
git clone https://github.com/NLaundry/MacAutoSetup.git ~/dev/MacAutoSetup
cd ~/dev/MacAutoSetup
./bootstrap.sh
```

Fresh Mac (no git yet):

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/NLaundry/MacAutoSetup/main/bootstrap-nogit.sh)
```

## After install

A few manual steps macOS requires:

1. **AeroSpace** — grant Accessibility permission when prompted
2. **Borders** — grant Screen Recording permission if prompted
3. **Hide native menu bar** *(optional for cleaner look)* — System Settings → Desktop & Dock → Automatically hide and show the menu bar → Always

## Dotfiles

Managed with GNU Stow. Each directory maps directly to `$HOME`:

```
dotfiles/
├── zsh/          → ~/.zshrc
├── aerospace/    → ~/.config/aerospace/aerospace.toml
├── ghostty/      → ~/.config/ghostty/config
├── nvim/         → ~/.config/nvim/
├── tmux/         → ~/.tmux.conf
├── vim/          → ~/.vimrc
└── swiftbar/     → ~/Library/Application Support/SwiftBar/Plugins/spaces.sh
```

## AeroSpace keybindings

| Key | Action |
|---|---|
| `alt-h/j/k/l` | Focus window left/down/up/right |
| `alt-shift-h/j/k/l` | Move window |
| `alt-1` … `alt-6` | Switch workspace |
| `alt-shift-1` … `alt-shift-6` | Move window to workspace |
| `alt-tab` | Toggle last two workspaces |
| `alt-f` | Fullscreen |
| `alt-shift-space` | Float / tile toggle |
| `alt-r` | Resize mode |
| `alt-shift-;` | Service mode |
| `alt-t` | New Ghostty window |
| `alt-e` | New Brave Browser window |

Workspaces: `1` Terminal · `2` Browser · `3` Code · `4` Discord · `5` General · `6` Scratch
