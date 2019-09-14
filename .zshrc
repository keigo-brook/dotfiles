# Executes commands at the start of an interactive session.

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#unalias gls


plugins+=(git-aliases)

if [ -e ~/.rbenv ]; then
  [[ -d ~/.rbenv  ]] && eval "$(rbenv init -)"
fi

if [ -e ~/.pyenv ]; then
  eval "$(pyenv init -)"
fi

# function
function extname () {
  echo $1 | sed 's/\.[^\.]*$//'
}
function workstatus () {
  echo "push: ";
  rsync --exclude '.DS_Store' -avn --delete -e ssh ~/work myvps:~/;
  echo "pull: ";
  rsync --exclude '.DS_Store' -avn --delete -e ssh myvps:~/work ~/;
}

function run () {
  num=$1
  shift
  for i in `seq $num`; do
    $@
  done
}

function ssht() {
  ssh -t $1 tmux new -s "$(whoami)_$(date +%m%d%y)"
}

function ssha() {
  if [ $# -eq 0 ]; then
    echo "usage: ssha [host] [session name (optional)]"
  elif [ $# -eq 2 ]; then
    ssh -t $1 tmux attach -t $2
  else
    ssh -t $1 tmux attach
  fi
}

functio texc() {
  name=${1%.*}
  mkdir $name && touch ./${name}/${name}.tex
}

# alias
alias atg='atcoder_greedy'
alias c='clear'
alias docker-compose=dcom
alias fuck='eval $(thefuck $(fc -ln -1))'
alias ff='() { find $1 -iname $2 ${@:3} }'
alias gh='hub browse'
alias h='history -i'
alias ha='history -i -E 1'
alias le=less
alias pys='python -m http.server 8181'
alias pushwork='rsync --exclude ".DS_Store" -av -e ssh ~/work myvps:~/'
alias pullwork='rsync -av -e ssh myvps:~/work ~/'
alias pipupdate='pip freeze --local | grep -v "^\-e" | cut -d = -f 1 | xargs pip install -U'
alias pip3update='pip3 freeze --local | grep -v "^\-e" | cut -d = -f 1 | xargs pip3 install -U'
alias rez='source ~/.zshenv && source ~/.zshrc'
alias ssht=ssht
alias ssha=ssha
alias synclab='rsync -av -e ssh ./work labogawa:~/'
alias up='cd ..; ls -l'

# language-alias
function runcpp () {
  name=$(extname $1)
  outdir='/tmp/'
  g++ $1 -std=c++11 -O3 -Wall -o $outdir$name && shift && $outdir$name $@
}
function runrust() {
  name=$(extname $1)
  rustc $1 && shift && ./$name $@
}

alias be='bundle exec'
alias ruby='ruby -w'
alias -s rb=ruby
alias -s py=python
alias -s {c,cpp,cc}=runcpp
alias -s rs=runrust
alias cb='cargo build'
alias cr='cargo run'
alias crb='cargo run --bin'
alias gcc='nocorrect gcc -Wall'

# completions
compdef ssht=ssh
compdef ssha=ssh

# emacs
# Checks if there's a frame open
function emcheck() {
  emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" 2> /dev/null | grep t &> /dev/null;
}

# open file in Window (GUI)
function eg() {
  emcheck;
  if [ "$?" -eq "1" ]; then
    emacsclient -a '' -nqc "$@" &> /dev/null;
  else
    emacsclient -nq "$@" &> /dev/null;
  fi
}

# open file in Terminal (CUI)
function et() {
  emcheck;
  if [ "$?" -eq "1" ]; then
    emacsclient -a '' -qt "$@";
  else
    emacsclient -qt "$@";
  fi
}

alias ed='emacs --daemon'
alias ek='emacsclient -e "(kill-emacs)"'
alias er='ek && ed'

case ${OSTYPE} in
  darwin*)
    # macOS specific settings
    alias ek='brew services stop emacs-plus'
    alias er='brew services restart emacs-plus'
    alias showhidden='defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;'
    alias hidehidden='defaults write com.apple.finder AppleShowAllFiles -boolean false; killall Finder;'
    alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:?/} brew"
    alias rm='rmtrash'
    cdf() {
      cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
    }
    alias egn='open -a Emacs.app'
    alias -s {png,jpg,jpeg,bmp}=imgcat
    alias catpbc='(){ cat $1 | pbc }'
    alias wget='curl -O'

    if type peco > /dev/null; then
      function peco-history-selection() {
        BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
        CURSOR=$#BUFFER
        zle reset-prompt
      }

      zle -N peco-history-selection
      bindkey '^R' peco-history-selection
    fi
    ;;
  linux*)
    # linux specific settings
    [[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]] && TERM=xterm-256color

    alias open='-open'
    alias pbc='xsel --clipboard --input'
    # カーソルの色指定（暗めの緑色）
    echo -ne '\e]12;#009900\a'

    if type dstat > /dev/null; then
      alias dstat-full='dstat -Tclmdrn'
      alias dstat-mem='dstat -Tclm'
      alias dstat-cpu='dstat -Tclr'
      alias dstat-net='dstat -Tclnd'
      alias dstat-disk='dstat -Tcldr'
    fi

    if type peco > /dev/null; then
      function peco-history-selection() {
        BUFFER=$(\history -n 1 | tac | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
      }
      zle -N peco-history-selection
      bindkey '^r' peco-history-selection
    fi
    ;;
esac

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
