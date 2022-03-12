export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

uname=`uname -s`
if [ $uname = 'Darwin' ]; then
  OS='mac'
elif [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
  OS='wsl'
elif [ "$(expr substr $uname 1 5)" = 'Linux' ]; then
  OS='linux'
fi

if [ $OS = 'mac' ]; then
  alias ls="ls -G"
elif [ $OS = 'linux' ] || [ $OS = 'wsl' ]; then
  alias ls="ls --color --group-directories-first"
fi
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias c=clear
alias py=python3
alias numpy="PYTHONSTARTUP=${HOME}/.startup_numpy.py python3"
alias np=numpy
alias pandas="PYTHONSTARTUP=${HOME}/.startup_pandas.py python3"
alias pd=pandas
alias gpp=g++
alias adb="/home/senz/Android/Sdk/platform-tools/adb"
alias ping8='ping 8.8.8.8'
alias pyserv='python3 -m SimpleHTTPServer'
alias ct='codetest'
alias gs='git status'
alias protect='sudo chattr +i'
alias datetime='date "+%Y%m%d_%H%M%S"'
alias grep_hilight='grep --color=always -e ^ -e'
alias pickclip='(){pickline $@ | clip}'
alias findword='(){find $1 -type f -print | xargs grep -n $2}'
alias mypy='python3 -m mypy'

autoload -U compinit promptinit
autoload colors
colors
compinit
promptinit

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "%F{blue}[%b]%f"

PROMPT="%n[%T]%# "
#RPROMPT="%d"

# precmd(){
# 	psvar=()
# 	psvar[1]=$(acpi | grep -o "[0-9]*%")
# }
# BATT='%1v'
# 
# PROMPT="%n[%T $BATT]%# "

precmd () {
  print

  local left='%{${fg[yellow]}%}%~%{${reset_color}%}'
  vcs_info
  local right='${vcs_info_msg_0_}'

  print -P $left $right
}

zshaddhistory(){
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # if $cmd==v or ==vv, don't add to history
    [[ ${cmd} != (v|vv|p) ]]
}


function mdcat(){
    pandoc $1 | lynx -stdin
}

function pickline(){
    # Usage: pickline filename s [n]
    #
    # Outputs:
    #   first of n is '+' or '-':
    #     s-th to (s+n)-th lines of filename
    #   else:
    #     s-th to n-th lines of filename
    # 

    if [ $# -gt 2 ]; then
        if [ ${3:0:1} = + ]; then
          nline=${3:1}
          sline=$2
        elif [ ${3:0:1} = - ]; then
          nline=${3:1}
          sline=$(($2-${nline}+1))
        else
          if [ $3 -lt $2 ];then
            echo "Warning: $3 < $2" >&2
            nline=1
            sline=$2
          else
            nline=$(($3-$2+1))
            sline=$2
          fi
        fi
    else
        nline=1
        sline=$2
    fi
    head -$((${sline}+${nline}-1)) $1 | tail -${nline}
}


# for programming contest
function codetest(){
    if [ $# -ne 2 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo "Usage: codetest source_code test_file"
    elif [[ $1 =~ "\.py$" ]]; then
        cat $2 | python3 $1
    elif [[ $1 =~ "\.c$" ]]; then
        gcc $1; cat $2 | ./a.out 
    elif [[ $1 =~ "\.cpp$" ]]; then
        g++ $1; cat $2 | ./a.out 
    fi
}

function clip(){
  if [ $OS = 'linux' ]; then
    cat $1 | xsel --clipboard --input
  elif [ $OS = 'wsl' ]; then
    cat $1 | clip.exe
  fi
}

function v(){
    # Search for the last cmd that start with 'v'
    cmd=`fc -ln 1 | grep "^v." | tail -1`
    echo $cmd
    print -Sr $cmd # add to history
    cmd=`echo $cmd | sed -e "s|~|$HOME|"`
    sleep 0.2
    eval $cmd
}

function vv(){
    # Search for the second last cmd that start with 'v' except duplication
    if [ $OS = 'mac' ]; then
      cmd=`fc -ln 1 | grep "^v." | tail -r | awk '!a[$0]++' | head -2 | tail -1`
    elif [ $OS = 'linux' ] || [ $OS = 'wsl' ]; then
      cmd=`fc -ln 1 | grep "^v." | tac | awk '!a[$0]++' | head -2 | tail -1`
    fi
    echo $cmd
    print -Sr $cmd # add to history
    cmd=`echo $cmd | sed -e "s|~|$HOME|"`
    sleep 0.2
    eval $cmd
}

function p(){
    # Search for the last cmd that start with 'p' and its length is larger than 2
    cmd=`fc -ln 1 | grep "^p.." | tail -1`
    echo $cmd
    print -Sr $cmd # add to history
    cmd=`echo $cmd | sed -e "s|~|$HOME|"`
    eval $cmd
}




[ -f ~/.zshrc.local ] && source ~/.zshrc.local

