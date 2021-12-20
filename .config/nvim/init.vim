lua require 'init'
" set packpath=/usr/local/share/nvim/runtime,~/.local/share/nvim/site
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim

" Plugins
" Run :PlugInstall to download plugins
" Update with :PlugUpdate
call plug#begin('~/.vim/plugged')

" vim ranger
"Plug 'rbgrouleff/bclose.vim'
" Plug 'francoiscabrol/ranger.vim'

" tokyonight colorscheme
" Plug 'folke/tokyonight.nvim'

" bracket autoclose
" Plug 'jiangmiao/auto-pairs'

" syntax language packs
Plug 'sheerun/vim-polyglot'

" status bar
Plug 'itchyny/lightline.vim'

" comment out blocks
Plug 'KarimElghamry/vim-auto-comment'

" ale linting
" Plug 'dense-analysis/ale'

" vim-jukit
" Plug 'luk400/vim-jukit' 

" git integration
" Plug 'tpope/vim-fugitive'

" Latex support
" Plug 'lervag/vimtex'

" mardown preview
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" python support
let g:python3_host_prog = '/home/kro/anaconda3/envs/neovim/bin/python3'

" remove auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" vim esc in terminal
tnoremap<Esc> <C-\><C-n>

" latex
let g:vimtex_view_method = 'zathura'

" remove trailing spaces
autocmd BufWritePre *.py :%s/\s\+$//e

" vim-jukit
let g:jukit_pdf_viewer = 'zathura'
let g:jukit_html_viewer = 'firefox'

" lightline
set laststatus=2
let g:lightline = {'colorscheme' : 'tokyonight'}

" tokyonight colorscheme
set termguicolors

" lsp stuff
function Refresh()
	lua vim.lsp.stop_client(vim.lsp.get_active_clients())
 	sleep 300m
    write
	edit
endfunction

command RefreshLSP call Refresh()
nnoremap <leader>w :RefreshLSP<CR>
