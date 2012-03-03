export PATH="$HOME/local/bin:$HOME/bin:/opt/local/sbin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
if [ ! -z `which keychain` ]; then
    keychain id_rsa
    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
    [ -f $HOME/.keychain/$HOSTNAME-sh ] && . $HOME/.keychain/$HOSTNAME-sh
else
    agentPID=`ps gxww | grep "ssh-agent]*$" | awk '{print $1}'`
    agentSOCK=`ls -t /tmp/ssh*/agent* | head -1`
    if [ -z "$agentPID" -o -z "$agentSOCK" ]; then
        unset SSH_AUTH_SOCK SSH_AGENT_PID
        eval `ssh-agent`
        ssh-add < /dev/null
    else
        export SSH_AGENT_PID=$agentPID
        export SSH_AUTH_SOCK=$agentSOCK
        if [ `ssh-add -l | grep "$HOME/.ssh/id_rsa" | wc -l` = "0" ]; then
            ssh-add < /dev/null
        fi
    fi
fi
