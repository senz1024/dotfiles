set number
set list listchars=tab:>_
set expandtab
set autoindent
set tabstop=4
set shiftwidth=4
syntax on

nnoremap <Down> gj
nnoremap <Up> gk

"move cursor to last position
au BufWritePost * mkview
autocmd BufReadPost * loadview

