export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH

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

PR_HOST='%F{green}%M%f'
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{yellow}%M%f'
fi

local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"

PROMPT="${user_host}:${current_dir} ${PR_PROMPT}"

#===== Env & Aliases
export EDITOR="nvim"
export VISUAL="nvim"

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias ll="ls -l"
alias la="ls -al"
alias lh="ls -alh"

alias t="tree"
