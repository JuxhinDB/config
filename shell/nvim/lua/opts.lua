--[[ opts.lua ]]
local opt = vim.opt -- with vim.opt we can set global, window and buffer settings, acting like :set in vimscript
local set = vim.opt
local o = vim.o
local cmd = vim.api.nvim_command

-- optionally enable 24-bit colour

vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Turn off macro recording
vim.cmd([[
  map q <Nop>
]])

opt.number = true -- bool: Show line numbers
opt.relativenumber = true -- bool: Show relative line numbers
opt.scrolloff = 4 -- int:  Min num lines of context
opt.signcolumn = "yes" -- str:  Show the sign column
opt.numberwidth = 4 -- gutter width
set.cursorline = true -- display cursor line
set.cursorlineopt = 'number' --

opt.encoding = 'utf8' -- str:  String encoding to use
opt.fileencoding = 'utf8' -- str:  File encoding to use

opt.syntax = "ON"
opt.termguicolors = true

opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true -- bool: Override ignorecase if search contains capitals
opt.incsearch = true -- bool: Use incremental search
opt.hlsearch = false -- bool: Highlight search matches

opt.expandtab = true -- bool: Use spaces instead of tabs
opt.shiftwidth = 4 -- num:  Size of an indent
opt.softtabstop = 4 -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4 -- num:  Number of spaces tabs count for

opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one

opt.clipboard = 'unnamedplus' -- string: use system clipboard

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)


-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
  set signcolumn=yes
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.cmd([[
  let g:vimspector_sidebar_width = 85
  let g:vimspector_bottombar_height = 15
  let g:vimspector_terminal_maxwidth = 70
]])

vim.cmd([[
  nmap <F9> <cmd>call vimspector#Launch()<cr>
  nmap <F5> <cmd>call vimspector#StepOver()<cr>
  nmap <F8> <cmd>call vimspector#Reset()<cr>
  nmap <F11> <cmd>call vimspector#StepOver()<cr>")
  nmap <F12> <cmd>call vimspector#StepOut()<cr>")
  nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])

vim.cmd([[
  map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
  map('n', "Dw", ":call vimspector#AddWatch()<cr>")
  map('n', "De", ":call vimspector#Evaluate()<cr>")
]])

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        border = 'single',
        source = 'always',
        header = '',
        prefix = '- ',
    },
})
-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.o.updatetime = 350
set.signcolumn = 'yes'
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])