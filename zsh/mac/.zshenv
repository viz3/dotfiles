setopt NO_GLOBAL_RCS
ARCH=`uname -m`
if [[ $ARCH == 'arm64' ]]; then
    PROMPT="[a] %m:%~%# "
else
    PROMPT="[x] %m:%~%# "
fi
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
if [[ $ARCH == 'arm64' ]]; then
    PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
fi
export PATH

# for rbenv
# https://github.com/sstephenson/rbenv/
if [[ $ARCH == 'arm64' ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - zsh)"
fi

# for pyenv
if [[ $ARCH == 'arm64' ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# for nodenv
if [[ $ARCH == 'arm64' ]]; then
  eval "$(nodenv init -)"
fi

# for golang
export PATH="/usr/local/go/bin:$PATH"

alias ls='ls -G'
alias chrome-viz3dev='nohup /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/Users/yusuke-odate/Library/Application\ Support/Google/Chrome/viz3dev &'
alias chrome-pot='nohup /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/Users/yusuke-odate/Library/Application\ Support/Google/Chrome/pot --proxy-server="socks5://127.0.0.1:30889" &'
