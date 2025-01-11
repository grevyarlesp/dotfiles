local map = vim.keymap.set

-- Reset keymap
map({ "n", "v" }, vim.g.mapleader, "<Nop>", { silent = true })
map({ "n", "v" }, "<C-f>", "<Nop>", { silent = true })
map({ "n", "v" }, "<C-b>", "<Nop>", { silent = true })
map({ "n", "v" }, "<C-z>", "<Nop>", { silent = true })
map({ "n", "v" }, "<tab>", "<Nop>", { silent = true })
map("n", "<C-i>", "<C-i>", { noremap = true })

-- Better scroll
map("n", "<C-y>", "5<C-y>")
map("n", "<C-e>", "5<C-e>")

map("t", "<Esc>", "<C-\\><C-n>")
map("n", "<leader><bs>", "<cmd>nohlsearch<cr>", { noremap = true, desc = "Clear Highlight" })

-- Better copy and paste

map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>y", '"+y')
map("n", "<leader>yy", '"+yy')

map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')

-- Apply @record to multiple lines
---@see https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
map("x", "@", function()
  local register = vim.fn.nr2char(vim.fn.getchar())
  vim.print("@" .. vim.fn.getcmdline())
  return ":'<,'>normal @" .. register .. "<cr>"
end, { silent = true, expr = true }) -- expr = true will execute return value of function

-- Better Yank & Paste
---@see https://stackoverflow.com/questions/290465/how-to-paste-over-without-overwriting-register
---@see https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
-- xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>
-- use P instead of p because it doesn't override register
map("n", "Y", "y$", { desc = "Copy to end of line" })
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- quickfix list
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })
map("n", "[q", "<cmd>cprevious<cr>", { desc = "Prev Quickfix" })
-- buffer list
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- Undo breakpoint
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")

-- Jumplist mutations
map("n", "<M-k>", [[ (v:count > 5 ? "m'" . v:count : "") . 'gk']], { expr = true, silent = true })
map("n", "<M-j>", [[ (v:count > 5 ? "m'" . v:count : "") . 'gj']], { expr = true, silent = true })
-- Move only sideways in command mode. Using `silent = false` makes movements
-- to be immediately shown.
map("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })
-- Don't `noremap` in insert mode to have these keybindings behave exactly
-- like arrows (crucial inside TelescopePrompt)
map("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })
map("t", "<M-h>", "<Left>", { desc = "Left" })
map("t", "<M-j>", "<Down>", { desc = "Down" })
map("t", "<M-k>", "<Up>", { desc = "Up" })
map("t", "<M-l>", "<Right>", { desc = "Right" })

map("i", "<M-w>", "<S-Right>")
map("i", "<M-b>", "<S-Left>")

-- Utilities
map("n", "<leader>pl", "<cmd>Lazy<cr>", { desc = "Show Lazy" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Show Mason" })
