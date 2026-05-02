# ── Plugins ───────────────────────────────────────────────────────────────────
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/supercharge"
plug "wintermi/zsh-brew"
plug "MichaelAquilina/zsh-you-should-use"
plug "MichaelAquilina/zsh-auto-notify"
plug "hlissner/zsh-autopair"
plug "chrissicool/zsh-256color"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR=nvim
export GIT_EDITOR=nvim

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/go/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ANDROID_HOME=$HOME/cmdline-tools
export PATH="$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Starknet
export STARKNET_ACCOUNT=~/.starkli-wallets/signer3/account.json
export STARKNET_KEYSTORE=~/.starkli-wallets/signer3/keystore.json

# Tokens
export NPM_TOKEN_ALM=""
export NPM_TOKEN_DCA=""
export COLOSSEUM_COPILOT_API_BASE="https://copilot.colosseum.com/api/v1"
export COLOSSEUM_COPILOT_PAT=""
export HF_TOKEN=""

# ── Aliases ───────────────────────────────────────────────────────────────────
alias sed='gsed'
alias awk='gawk'
alias c='clear'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# eza
alias ls='eza -1   --icons=auto'
alias l='eza -lh   --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'

# Dev
alias bd='bun dev'
alias bi='bun install'
alias ba='bun add'
alias bs='bun start'
alias bb='bun run build'
alias nd='npm run dev'
alias ni='npm install'
alias pd='pnpm run dev'
alias pi='pnpm install'
alias yd='yarn run dev'
alias yi='yarn install'
alias ya='yarn add'
alias gc='git clone'

# Docker
alias ds='docker ps'
alias dsa='docker ps -a'
alias du='docker compose up -d'
alias dd='docker compose down'

# Tmux
alias ta='tmux attach'

# Brew
alias up='brew update && brew upgrade'
alias pl='brew list'
alias pa='brew search'
alias pc='brew cleanup'

# ── Functions ─────────────────────────────────────────────────────────────────
function copy-to-clipboard {
    if ((REGION_ACTIVE)); then
        local start_pos=$((MARK+1)) end_pos=$CURSOR
        ((start_pos > end_pos)) && { local t=$start_pos; start_pos=$end_pos; end_pos=$t }
        local selected="${BUFFER[start_pos,end_pos]}"
        [[ -n "$selected" ]] && echo -n "$selected" | pbcopy
        zle deactivate-region
    fi
}
zle -N copy-to-clipboard

function select-word-backward { local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'; zle set-mark-command; zle backward-word; }
function select-word-forward  { local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'; zle set-mark-command; zle forward-word; }
function select-to-start      { zle set-mark-command; zle beginning-of-line; }
function select-to-end        { zle set-mark-command; zle end-of-line; }
zle -N select-word-backward
zle -N select-word-forward
zle -N select-to-start
zle -N select-to-end

# ── Bindings ──────────────────────────────────────────────────────────────────
bindkey '^s'   backward-kill-word
bindkey '^H'   backward-kill-word
bindkey '^w'   kill-word
bindkey '^a'   backward-kill-line
bindkey '^d'   kill-line
bindkey '^[s'  select-word-backward
bindkey '^[w'  select-word-forward
bindkey '^[a'  select-to-start
bindkey '^[d'  select-to-end
bindkey '^[c'  copy-to-clipboard
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ── Completions & Hooks ───────────────────────────────────────────────────────
autoload -Uz compinit && compinit

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export AUTO_NOTIFY_IGNORE=("docker" "npm" "yarn" "pnpm" "forge" "remixd" "tmux")
