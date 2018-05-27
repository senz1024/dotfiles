export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

uname=`uname -s`
if [ $uname = 'Darwin' ]; then
  OS='mac'
elif [ "$(expr substr $uname 1 5)" = 'Linux' ]; then
  OS='linux'
fi

if [ $OS = 'mac' ]; then
  alias ls="ls -G"
elif [ $OS = 'linux' ]; then
  alias ls="ls --color"
fi
alias c=clear
alias py=python
alias gpp=g++
alias adb="/home/senz/Android/Sdk/platform-tools/adb"
alias ping8='ping 8.8.8.8'
alias pyserv='python -m SimpleHTTPServer'
alias ct='codetest'
alias gs='git status'


autoload -U compinit promptinit
autoload colors
colors
compinit
promptinit

# precmd(){
# 	psvar=()
# 	psvar[1]=$(acpi | grep -o "[0-9]*%")
# }
# BATT='%1v'
# 
# PROMPT="%n[%T $BATT]%# "
PROMPT="
%{${fg[yellow]}%}%~%{${reset_color}%}
%n[%T]%# "
# RPROMPT="%d"

zshaddhistory(){
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # if $cmd==v or ==vv, don't add to history
    [[ ${cmd} != (v|vv) ]]
}


function my-network-reset(){
    sudo /etc/init.d/network-manager stop
    sudo iwconfig wlp3s0 power off
    sudo service network-manager restart
}

function mdcat(){
    pandoc $1 | lynx -stdin
}

TEXINPUTS=$TEXINPUTS:/usr/share/texlive/texmf-dist/tex/latex/

# for programming contest
function codetest(){
    if [ $# -ne 2 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo "Usage: codetest source_code test_file"
    elif [[ $1 =~ "\.py$" ]]; then
        cat $2 | python $1
    elif [[ $1 =~ "\.c$" ]]; then
        gcc $1; cat $2 | ./a.out 
    elif [[ $1 =~ "\.cpp$" ]]; then
        g++ $1; cat $2 | ./a.out 
    fi
}

function clip(){
  cat $1 | xsel --clipboard --input
}

function v(){
    # Search for the last cmd that start with 'v'
    cmd=`fc -ln 1 | grep "^v." | tail -1`
    echo $cmd
    print -S $cmd # add to history
    cmd=`echo $cmd | sed -e "s|~|$HOME|"`
    sleep 0.2
    eval $cmd
}

function vv(){
    # Search for the second last cmd that start with 'v' except duplication
    if [ $OS = 'mac' ]; then
      cmd=`fc -ln 1 | grep "^v." | tail -r | awk '!a[$0]++' | head -2 | tail -1`
    elif [ $OS = 'linux' ]; then
      cmd=`fc -ln 1 | grep "^v." | tac | awk '!a[$0]++' | head -2 | tail -1`
    fi
    echo $cmd
    print -S $cmd # add to history
    cmd=`echo $cmd | sed -e "s|~|$HOME|"`
    sleep 0.2
    eval $cmd
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

