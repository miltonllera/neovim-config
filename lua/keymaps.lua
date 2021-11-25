local Utils = require('utils')

-- local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
-- local tnoremap = Utils.tnoremap
-- local nmap = Utils.nmap
-- local xmap = Utils.xmap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- kj to normal mode
inoremap("kj", "<Esc>")

-- Run omnifunc, mostly used for autocomplete
inoremap("<C-SPACE>", "<C-x><C-o>")

-- Save with Ctrl + S
nnoremap("<C-s>", ":w<CR>")

-- Move around windows
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Switch buffers (needs nvim-bufferline)
nnoremap("<TAB>", ":BufferLineCycleNext<CR>")
nnoremap("<S-TAB>", ":BufferLineCyclePrev<CR>")

-- Delete buffer
nnoremap("<A-w>", ":bd<CR>")

-- Yank to end of line
nnoremap("Y", "y$")

-- Copy to system clippboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')

-- TODO: Paste from system clippboard

-- Show line diagnostics
nnoremap("<leader>d", '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>')

-- Open local diagnostics in local list
nnoremap("<leader>fd", "<cmd>lua vim.diagnostic.setloclist()<CR>")

-- Open all project diagnostics in quickfix list
nnoremap("<leader>D", "<cmd>lua vim.diagnostic.setqflist()<CR>")

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")

-- NvimTree
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")

-- EasyAlign
-- xmap("ga", "<cmd>EasyAlign")
-- nmap("ga", "<cmd>EasyAlign")
