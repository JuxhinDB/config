set shell=/bin/bash
let mapleader = "\<Space>"

" Initialise the plugin system
call plug#begin()

" Load plugins
" NeoVim enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'justinmk/vim-sneak'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" Semantic Language Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '/.install --all' }
Plug 'junegunn/fzf.vim'

" Rust Plugins
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'

" Python Plugins
Plug 'tmhedberg/SimplyFold'
Plug 'nvie/vim-flake8'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/indentpython.vim'

" Initialise the plugin system
call plug#end()

" Some NeoVim specific configuration
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" JavaScript settings
let javaScript_fold=0

" Java Settings
let java_ignore_javadoc=1

" LaTeX
let g:latex_indent_enabled=1
let g:latex_fold_envs=0
let g:latex_fold_sections=[]

" Open file hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Toggle between previous/current buffers
nnoremap <leader><leader> <c-^>

" Setup split-pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Python & PEP8 specific configuration
let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4       |
    \ set softtabstop=4   |
    \ set shiftwidth=4    |
    \ set textwidth=119   |
    \ set expandtab       |
    \ set autoindent      | 
    \ set fileformat=unix
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
let g:syntastic_python_python_exec = '/usr/bin/python3'

" Racer & Rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" GUI Settings
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set ttyfast

" Set word folding and allow unfolding via space
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

set number
set showcmd
set mouse=a
set relativenumber
set encoding=utf-8
set diffopt+=iwhite
set clipboard=unnamed
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set shortmess+=c " don't give |ins-completion-menu| messages.

" Ignore certain files and directories when performing fuzzy searches
set wildignore+=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,*/build/*,package-lock.json,target/debug/*

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
