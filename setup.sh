#!/bin/bash

cp .vimrc ${HOME}
echo cp .vimrc ${HOME}

if [ ! -e ${HOME}/.vim ]; then
  mkdir ${HOME}/.vim
  echo mkdir ${HOME}/.vim
fi

cp .zshrc ${HOME}
echo cp .zshrc ${HOME}

cp .gitconfig ${HOME}
echo cp .gitconfig ${HOME}

cp .startup_numpy.py ${HOME}
echo cp .startup_numpy.py ${HOME}

cp .tmux.conf ${HOME}
echo .tmux.conf ${HOME}

cp .aspell.conf ${HOME}
echo .aspell.conf ${HOME}

if [[ -f /etc/lsb-release ]]; then
  dist=$(head -1 /etc/lsb-release | rev | cut -c 1-6 | rev)
  if [ $dist = 'Ubuntu' ] || [ $dist = 'ubuntu' ]; then
    cat zshrclocal/zshrclocal-ubuntu > ${HOME}/.zshrc.local
    echo "cat zshrclocal/zshrclocal-ubuntu > ${HOME}/.zshrc.local"

    if [[ -e /usr/share/texlive/texmf-dist/tex/latex/ ]]; then
      cat zshrclocal/zshrclocal-tex >> ${HOME}/.zshrc.local
      echo "cat zshrclocal/zshrclocal-tex >> ${HOME}/.zshrc.local"
    fi
  fi
fi

