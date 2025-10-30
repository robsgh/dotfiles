
# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# ===== PATH & Cargo =====
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ===== History =====
HISTFILE=~/.bash_history
HISTSIZE=1000000000
HISTFILESIZE="${HISTSIZE}"
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# ===== Shell Config =====
# Emacs keybindings
set -o emacs

force_color_prompt=yes
color_prompt=yes

# Autocompletion
if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set show-all-if-unmodified on'

bind 'set completion-query-items 200'
bind 'set visible-stats on'
bind 'set match-hidden-files off'
bind 'set page-completions off'
bind 'set skip-completed-text on'
bind 'set colored-stats on'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# ===== Environment =====
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export VISUAL="nvim"

if command -v fzf &> /dev/null; then
  if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
  fi
  if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
  fi
fi

# ===== Aliases =====
alias e="$EDITOR"
alias se="sudo $EDITOR"

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias egrep="grep -E"

if command -v eza &>/dev/null; then
  alias ls="eza -h"
else
  alias ls="ls -h --color=auto"
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# ls chain to make life simplier
alias la="ls -a"
alias ll="la -l --icons=auto"
alias lru="ll -r"
alias l="ll"

alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

alias f1="awk '{print \$1}'"
alias f2="awk '{print \$2}'"
alias f3="awk '{print \$3}'"
alias f4="awk '{print \$4}'"
alias f5="awk '{print \$4}'"

# Temporary edit file
etemp() {
  local tmpfile
  tmpfile="$(mktemp)"
  echo -n "Opening tempfile at " 1>2
  echo "$tmpfile"
  "$EDITOR" "$tmpfile"
}

# ===== Quick Navigation =====
alias docs="cd ~/Documents"
alias work="cd ~/Work"
alias dl="cd ~/Downloads"
alias dots="cd ~/dotfiles"

alias ee="e ~/.bashrc && source ~/.bashrc"
alias eee="e ~/.config/nvim"

# ===== Git Shortcuts =====
alias gita="git add"
alias gitc="git commit"
alias gitca="git commit -a"
alias gitco="git checkout"
alias gitf="git fetch"
alias gitl="git log"
alias gitp="git pull"
alias gitpu="git push"
alias gitr="git rebase"
alias gits="git status"
alias gitd="git diff"
