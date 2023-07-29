export PATH=$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

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

#===== Ensure ~/Wallpapers/ exists
if [[ ! -d "$HOME/Wallpapers" ]]; then
    mkdir "$HOME/Wallpapers"
fi

WALLPAPER_COUNT=$(ls "$HOME/Wallpapers/" | wc -l)
if [[ WALLPAPER_COUNT -eq 0 ]]; then
    WHVN_WALLPAPERS=(
        "qzzk9q.png"
        "n6x5el.jpg"
        "ox6orl.jpg"
        "gpzzdq.png"
        "ox19m9.jpg"
        "1kjrrg.jpg"
        "39p7gy.jpg"
        "gpwze3.png"
        "gjq7g3.jpg"
    )

    echo "Download wallpapers now? [Y/n]"
    read wallin
    if [[ $wallin = "y" ]] || [[ $wallin = "" ]]; then
        echo "Downloading..."
        for wallpaper in "${WHVN_WALLPAPERS[@]}"; do
            filename=$(echo $wallpaper | awk -F. '{print $1}')
            curl -fLo "$HOME/Wallpapers/$filename" "https://w.wallhaven.cc/full/${wallpaper:0:2}/wallhaven-$wallpaper"
        done
        echo "Done."
    else
        echo "Skipping wallpaper download."
    fi
fi

#===== Include Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

#===== Env & Aliases
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"

alias vim="nvim"
alias ll="ls -l"
alias la="ls -al"
alias lh="ls -alh"
alias mkdirp="mkdir -p"

alias vidots="nvim -c ':cd ~/dots' -c ':NvimTreeOpen' ~/dots/"
alias vizshrc="nvim ~/.zshrc && source ~/.zshrc"
alias dotify="bash -c '~/dots/dotify.sh'"
alias commitdots="cd ~/dots && git commit -a && cd -"

alias ssha='eval `ssh-agent -s`'
alias sshk='eval `ssh-agent -k`'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
