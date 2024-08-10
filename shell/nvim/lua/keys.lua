-- Functional wrapper for mapping custom keybindings
-- mode (as in Vim modes like Normal/Insert mode)
-- lhs (the custom keybinds you need)
-- rhs (the commands or existing keybinds to customise)
-- opts (additional options like <silent>/<noremap>, see :h map-arguments for more info on it)
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F1>", ":luafile ~/.config/nvim/lua/opts.lua<cr>")

-- Enable spell checking
map("n", "<F2>", ":set spell!<cr>")

vim.cmd([[
  " Copy to clipboard
  vnoremap  <leader>y  "+y
  nnoremap  <leader>Y  "+yg_
  nnoremap  <leader>y  "+y
  nnoremap  <leader>yy  "+yy
  " Paste from clipboard
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P
  vnoremap <leader>p "+p
  vnoremap <leader>P "+P
]])

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>qa", ":qa<CR>")

vim.cmd([[
  nmap <silent> <c-k> :wincmd k<CR>
  nmap <silent> <c-j> :wincmd j<CR>
  nmap <silent> <c-h> :wincmd h<CR>
  nmap <silent> <c-l> :wincmd l<CR>
]])

-- Telescope
-- Keeping it basic
map("n", "<leader>f", ":lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>g", ":lua require('telescope.builtin').live_grep()<cr>")

-- FloatTerm
map('n', "<leader>tt", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

map("n", "<leader>n", ":NvimTreeToggle<CR>")

map('n', "ca", ":lua vim.lsp.buf.code_action()<CR>")
vim.cmd([[
  nnoremap <silent> gs     <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
  nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> rn        <cmd>lua vim.lsp.buf.rename()<CR>
]])