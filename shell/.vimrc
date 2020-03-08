set shell=/bin/bash

" Initialise the plugin system
call plug#begin()

" Load plugins
" NeoVim enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'justinmk/vim-sneak'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'


" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '/.install --all' }
Plug 'junegunn/fzf.vim'

" Rust Plugins
Plug 'racer-rust/vim-racer'

" Initialise the plugin system
call plug#end()

" Some NeoVim specific configuration
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" Adjust some colours
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" JavaScript settings
let javaScript_fold=0

" Java Settings
let java_ignore_javadoc=1

" LaTeX
let g:latex_indent_enabled=1
let g:latex_fold_envs=0
let g:latex_fold_sections=[]

" Quick-save
nmap <leader>w :w<CR>

" Racer & Rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
"let g:racer_cmd = "/usr/bin/racer"
"let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
