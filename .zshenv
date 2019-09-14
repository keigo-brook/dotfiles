# Defines environment variables.
export LC_ALL=en_US.UTF-8

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# PATH settings
setopt no_global_rcs

PATH=$PATH:/Library/TeX/texbin

export PATH="/usr/local/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
ANT_HOME='/usr/bin/'
PATH=$ANT_HOME/bin:$PATH
# Add pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Add metasploit path
export PATH="/opt/metasploit-framework/bin:$PATH"

# Add cabal path
export PATH="$HOME/.cabal/bin:$PATH"

# go path
case ${OSTYPE} in
    darwin*)
    # macOS path
    export GOPATH=$HOME/gocode
    export PATH=$GOPATH/bin:$PATH
    ;;
    linux*)
    export GOPATH=$HOME/go
    export PATH="$PATH:$HOME/go/bin:/usr/local/go/bin"
    ;;
esac

# Add cargo path
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="/usr/local/src/rust/src"
export CARGO_HOME="$HOME/.cargo"

export PATH=$HOME/.rbenv/bin:$PATH
