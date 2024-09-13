export LC_ALL=ja_JP.UTF-8

PROMPT="%F{cyan}[%~]%f %# "

#prevent Ctrl+D logout
setopt IGNOREEOF

#prevent Ctrl+S command for vim
stty -ixon

#comp
autoload -Uz compinit
compinit

#history
setopt share_history
setopt histignorealldups
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt nonomatch

#directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

#common setting
alias updatedb='sudo /usr/libexec/locate.updatedb'
export PATH=$PATH:$HOME/dotfiles/bin
export EDITOR=/usr/local/bin/vim
export SHELL=/usr/local/bin/zsh

#common alias
alias ll='ls -ltr'
alias la='ls -a'
alias lal='ls -al'
alias l='less'
alias cdp='cd ../'
alias cdpp='cd ../../'
alias reload_zshrc="source ~/.zshrc"
alias hg='history 1 | grep'

#git
alias delbranch='git branch | grep -v "*" | grep -v "develop\|master" | xargs -I % git branch -d %;git fetch --prune'
alias pull='git pull'
alias push='git push'
alias st='git status'
alias stt='git status -uno'
alias git-submodule-rm="git rm-submodule --no-commit"
alias gitu="git unstage"
alias reb='git svn rebase'
alias gl="git clone"
alias gu="git fetch --tags --prune&& git pull origin"
alias tb="git symbolic-ref --short HEAD|tr -d \"\\n\""
alias cmam="git commit -a -m"
alias co="~/dotfiles/co.sh"
alias cob="~/dotfiles/cob.sh"
alias bl="git branch"

#docker
alias dlog='docker logs'
alias dlogf='docker logs -f'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dim='docker images'
alias drm='docker rm $(docker ps -aqf "status=exited") 2> /dev/null'
alias dirm='docker rmi $(docker images -aqf "dangling=true") 2> /dev/null'
alias dc='docker-compose'
alias dcrun='dc run --service-ports'
alias dclog='dc logs --tail=100'
alias dclogf='dc logs -f --tail=100'
function dcrm() {
    dc stop $1 && dc rm -f $1
}
function dreslogf() {
    docker restart $1 && dlogf $1
}

#golang
export GOPATH=$HOME/go
export GODEBUG=asyncpreemptoff=1
export PATH=$PATH:$GOPATH/bin

switchGOROOT() {
	export GOROOT=`go$1 env GOROOT`
	export PATH=$GOROOT/bin:$PATH
	go version
}
switchGOROOT 1.22.7

# 重複したパスを削除
typeset -U PATH

#python
export PATH=$PATH:$HOME/Library/Python/3.10/bin

#tmux
[[ -s /Users/gsagawa/.tmuxinator/scripts/tmuxinator ]] && source /Users/gsagawa/.tmuxinator/scripts/tmuxinator

_tmuxinator() {
  local commands projects
  commands=(${(f)"$(tmuxinator commands zsh)"})
  projects=(${(f)"$(tmuxinator completions start)"})

  if (( CURRENT == 2 )); then
    _describe -t commands "tmuxinator subcommands" commands
    _describe -t projects "tmuxinator projects" projects
  elif (( CURRENT == 3)); then
    case $words[2] in
      copy|debug|delete|open|start)
        _arguments '*:projects:($projects)'
      ;;
    esac
  fi

  return
}

compdef _tmuxinator tmuxinator mux
alias mux="tmuxinator"

#ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#load localseting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

#peco,ghq setting
function peco-ghq-cd () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        selected_dir="`ghq root`/$selected_dir"
        BUFFER="cd ${selected_dir}"
    fi
    zle clear-screen
}
zle -N peco-ghq-cd
bindkey '^f' peco-ghq-cd

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/flutter/bin:$PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/tfenv/1.0.1/versions/0.12.9/terraform terraform

eval "$(direnv hook zsh)"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
