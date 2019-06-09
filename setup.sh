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

