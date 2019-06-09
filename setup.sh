cp .vimrc ${HOME}

if [ ! -e ${HOME}/.vim ]; then
  mkdir ${HOME}/.vim
fi

cp .zshrc ${HOME}
cp .gitconfig ${HOME}
cp .startup_numpy.py ${HOME}
cp .tmux.conf ${HOME}
