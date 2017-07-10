autoload -U compinit; compinit
bindkey -e

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value

# rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
setopt rm_star_silent

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history

if [ "x`virtualname 2>/dev/null`" = "x" ]; then
    PROMPT="%n@%m:%# "
else
    PROMPT="%n@`virtualname`:%# "
    #PROMPT="%# "
fi
RPROMPT="[%~]"

# ramdom prompt
if [ "$TERM" = "screen" ]; then
    local Mode=$[ $RANDOM % 3 ]
    local Color=$[ $RANDOM % 6 ]
    local RandomColor=$'%{\e[$Mode;$[31+$Color]m%}'
    local Default=$'%{\e[1;m%}'
    setopt PROMPT_SUBST
    PROMPT=${RandomColor}${PROMPT}${Default}
    if [ "x${RPROMPT}" != "x" ]; then
        RPROMPT=${RandomColor}${RPROMPT}${Default}
    fi
fi

# print latest executed command on screen status bar
if [ "$TERM" = "screen" ]; then
    local -a host
    if [ "x`virtualname 2>/dev/null`" = "x" ]; then
        host=`/bin/hostname -s`
    else
        host=`virtualname`
    fi
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
            echo -n "k$host:$cmd[1]:t\\"
    }
fi
