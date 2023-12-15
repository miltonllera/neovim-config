-- General keymaps that are not pluggin dependant
-- the file "lua/lsp/utils.lua" contains lsp-specific commands.

local Utils = require('utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
-- local tnoremap = Utils.tnoremap
-- local nmap = Utils.nmap
-- local xmap = Utils.xmap

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- kj to normal mode
inoremap("kj", "<Esc>")

-- page up/down with recentering
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")

-- Run omnifunc, mostly used for autocomplete
inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
nnoremap("<C-s>", ":w<CR>")

-- Close buffer
nnoremap("<C-c>", ":q<CR>")

-- Move around windows (shifted to the right)
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Switch buffers (needs nvim-bufferline)
nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")

-- Splits
nnoremap("<leader>ws", ":split<CR>")
nnoremap("<leader>vs", ":vsplit<CR>")

-- Populate substitution
nnoremap("<leader>s", ":s//g<Left><Left>")
nnoremap("<leader>S", ":%s//g<Left><Left>")
nnoremap("<leader><C-s>", ":%s//gc<Left><Left><Left>")

vnoremap("<leader>s", ":s//g<Left><Left>")
vnoremap("<leader><A-s>", ":%s//g<Left><Left>")
vnoremap("<leader>S", ":%s//gc<Left><Left><Left>")

-- Delete buffer
nnoremap("<A-w>", ":bd<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Paste into selection without overwriting p register
xnoremap("<leader>p", '\"_dP')

-- Delete without overwriting register
nnoremap("<leader>d", '\"_d')
vnoremap("<leader>d", '\"_d')

-- Copy to system clippboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')

-- Paste from system clippboard
nnoremap("<leader>P", '"+p')
vnoremap("<leader>P", '"+p')

-- Clear highlight search
nnoremap("<leader>nh", ":nohlsearch<CR>")
vnoremap("<leader>nh", ":nohlsearch<CR>")

-- Local list
nnoremap("<leader>lo", ":lopen<CR>")
nnoremap("<leader>lc", ":lclose<CR>")
nnoremap("<C-n>", ":lnext<CR>")
nnoremap("<C-p>", ":lprev<CR>")

-- Quickfix list
nnoremap("<leader>co", ":copen<CR>")
nnoremap("<leader>cc", ":cclose<CR>")
nnoremap("<C-N>", ":cnext<CR>")
nnoremap("<C-P>", ":cprev<CR>")

-- Open file in default application
nnoremap("<leader>xo", "<Cmd> !xdg-open %<CR><CR>")

-- Fugitive
nnoremap("<leader>G", ":G<CR>")
nnoremap("<leader>gl", ":Gclog<CR>")

-- Show line diagnostics
nnoremap("<leader>i", '<Cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
nnoremap("<leader>I", "<cmd>TroubleToggle document_diagnostics<cr>")

-- Open all project diagnostics in quickfix list
nnoremap("<leader><A-I>", "<cmd>TroubleToggle workspace_diagnostics<cr>")

-- Telescope
nnoremap("<leader>o", "<Cmd>Telescope find_files<CR>")
nnoremap("<leader>H", "<Cmd>Telescope find_files hidden=true<CR>")
nnoremap("<leader>b", "<Cmd>Telescope buffers<CR>")
nnoremap("<leader>lg", "<Cmd>Telescope live_grep<CR>")

-- File explorer
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")  -- NvimTree
-- nnoremap("<leader>e", "<Cmd>RnvimrToggle<CR>")

-- Run Copilot
nnoremap("<leader>C", "<Cmd>Copilot panel<CR>")

-- EasyAlign
-- xmap("ga", "<cmd>EasyAlign")
-- nmap("ga", "<cmd>EasyAlign")

-- For when everything else fails
nnoremap("<leader>fml", '<Cmd>CellularAutomaton make_it_rain<CR>')
