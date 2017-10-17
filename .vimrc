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

