lua require 'init'
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

" python support
let g:python3_host_prog = '/bin/python3.10'

" remove auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" remove trailing spaces
autocmd BufWritePre *.py :%s/\s\+$//e
" tokyonight colorscheme
" set termguicolors
