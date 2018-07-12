set viminfo='100,<1000,s10,h
set number
set list listchars=tab:>_
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
syntax on
filetype on

nnoremap <Down> gj
nnoremap <Up> gk

"move cursor to last position
au BufWritePost * mkview
autocmd BufReadPost * loadview

"In file *.py, tabstop=4
filetype plugin on
filetype indent on
autocmd FileType python setlocal sw=4 sts=4 ts=4 et

