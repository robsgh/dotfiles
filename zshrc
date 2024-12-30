export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH

#===== Prompt
setopt prompt_subst
PR_USER='%F{green}%n%f'
PR_USER_OP='%F{green}%#%f'
PR_PROMPT='%f$ %f'
if [[ $UID -eq 0 ]]; then
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}# %f'
fi

if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{yellow}%2m%f'
elif [[ "$TERM_PROGRAM" -eq "vscode" ]]; then
  PR_HOST='%F{green}%2m%f'
else
  PR_HOST='%F{red}%2m%f'
fi

local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"

PROMPT="${user_host}:${current_dir} ${PR_PROMPT}"

#===== Shell Config
HISTFILESIZE=-1
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTCONTROL=ignoredups
HISTFILE=~/.zsh_history.rob
setopt HIST_IGNORE_ALL_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt COMPLETE_IN_WORD

#===== Env & Aliases
export EDITOR="nvim"
export VISUAL="nvim"

alias t="tree"

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"
alias egrep="grep -E"

alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -alh"
alias lru="ls -alrh"

alias f1="awk '{print \$1}'"
alias f2="awk '{print \$2}'"
alias f3="awk '{print \$3}'"
alias f4="awk '{print \$4}'"
