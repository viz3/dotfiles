export PAGER="lv"
export EDITOR="vim"
if [ `uname` = "Linux" ]; then
    alias ls='ls --color=auto'
elif [ `uname` = "Darwin" ]; then
    alias ls='ls -G'
fi

alias genpasswd='cat /dev/urandom | uuencode -m - | head -n2 | tail -n1 | cut -c 1-8'

# for rbenv
# https://github.com/sstephenson/rbenv/
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#export DefaultIMModule=fcitx

