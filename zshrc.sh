# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:/home/luna/.cargo/bin:/home/luna/.dotnet/tools:/home/luna/.ghcup

export ZSH="$HOME/.oh-my-zsh"

plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

alias ls='ls --color=auto'
alias g='grep --color=auto'
alias vim='nvim'
alias files='ranger'
alias lg='lazygit'
alias activity='lua ~/Sync/Code/activity.lua'

alias code='~/Sync/Code'
alias config='~/Sync/Code/.config'
alias cam='/run/media/luna/KODAK\ AZ252/DCIM'

alias cr='cargo run'
alias cb='cargo build'
alias ca='cargo add'
alias cc='cargo clean'

alias hr='cabal run'
alias hb='cabal build'
alias ha='cabal get'
alias hc='cabal clean'

alias dr='dotnet run'
alias db='dotnet build'
alias da='dotnet add package'
alias dc='dotnet clean'

alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'

export VISUAL=nvim
export EDITOR=nvim

source ~/.key.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f "/home/luna/.ghcup/env" ] && source "/home/luna/.ghcup/env" # ghcup-env
