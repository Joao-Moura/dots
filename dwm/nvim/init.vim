" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" Icones
Plug 'kyazdani42/nvim-web-devicons'

" Nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

" Fuzzy file (control-p vscode)
Plug 'ctrlpvim/ctrlp.vim'

" Comentarios
Plug 'scrooloose/nerdcommenter'

" Vim-airline (interface)
Plug 'vim-airline/vim-airline'

call plug#end()

" Configurações e Shortcuts dos Plugins
" Nvim-tree
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'git': {
    \   'staged':	"S",
    \   'renamed': 	"R",
    \   'untracked': 	"U",
    \   'deleted': 	"D",
    \   'ignored': 	"I",
    \	'modified': 	"M",
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "0",
    \   'empty_open': "0",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \ }
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" NERDCommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Configurações do VIM
set mouse=a
set encoding=UTF-8
set number relativenumber
set tabstop=8
set shiftwidth=4
set autoindent
set smartindent
set cindent
set termguicolors
