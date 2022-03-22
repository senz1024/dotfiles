set viminfo='100,<1000,s10,h
set number
set list listchars=tab:>_,trail:-
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set title
set titleold=
set foldcolumn=1
autocmd ColorScheme * highlight Visual term=reverse cterm=None ctermbg=237 guibg=DarkGrey
colorscheme desert
syntax on
filetype on

nnoremap <Down> gj
nnoremap <Up> gk

"retain indent for the comment line
inoremap # X<C-H>#

"move cursor to last position
au BufWritePost * mkview
autocmd BufReadPost * loadview

"In file *.py, tabstop=4
filetype plugin on
filetype indent on
autocmd FileType python setlocal sw=4 sts=4 ts=4 et

"filetype for .ts
autocmd BufNewFile,BufRead *.ts set filetype=javascript
autocmd BufNewFile,BufRead *.tsx set filetype=javascript

