set shell=/bin/bash

" Initialise the plugin system
call plug#begin('~/.vim/plugged')

" Load plugins
" NeoVim enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'justinmk/vim-sneak'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedtyank'


" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '/.install --all' }
Plug 'junegunn/fzf.vim'

" Initialise the plugin system
call plug#end()
