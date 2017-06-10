export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

alias c=clear
alias py=python
alias ls="ls --color"
alias gpp=g++
alias adb="/home/senz/Android/Sdk/platform-tools/adb"
alias v='$(fc -ln 1 | grep "^v." | tail -1 | sed -e "s|~|$HOME|")'
alias ping8='ping 8.8.8.8'
alias pyserv='python -m SimpleHTTPServer'
alias ct='codetest'


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
    if [[ $1 =~ "\.py$" ]]; then
        cat $2 | python $1
    elif [[ $1 =~ "\.c$" ]]; then
        gcc $1; cat $2 | ./a.out 
    elif [[ $1 =~ "\.cpp$" ]]; then
        g++ $1; cat $2 | ./a.out 
    fi
}
