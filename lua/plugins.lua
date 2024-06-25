local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Themes
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  { 'marko-cerovac/material.nvim' },

  { "williamboman/mason.nvim", config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim" , config = function() require("mason-lspconfig").setup() end },

  { "neovim/nvim-lspconfig", config = function() require('plugins.lspconfig') end },

  -- Signature help
  {"ray-x/lsp_signature.nvim", config = function() require("lsp_signature").setup() end },

    -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    -- Sources for nvim-cmp
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('plugins.cmp') end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function() require('plugins.treesitter') end,
    build = ':TSUpdate'
  },

  -- Snippets
  {"L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end},
  {"rafamadriz/friendly-snippets"},

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    config = function() require('plugins.telescope') end,
  },

  {'nvim-telescope/telescope-fzf-native.nvim', build ='make'},

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  },

  -- statusline
  {
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  },

  -- NvimTree
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.nvimtree') end,  -- Must add this manually
  },

  -- Startify
  {
    'mhinz/vim-startify',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/startify.vim'
      vim.cmd('source '..path)
    end
  },

  {'folke/trouble.nvim', opts={}, cmd='Trouble'},

  -- git commands
  {'tpope/vim-fugitive'},

  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function() require('plugins.gitsigns') end
  },

  -- Formatting
  { 'tpope/vim-commentary' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'junegunn/vim-easy-align' },

  -- Copilot
  -- { "github/copilot.vim" },
  -- Use zbirenbaum's version since it is written in lua and is much more efficient
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require('plugins.copilot') end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  -- Python formatting
  { "EgZvor/vim-black" },
  { 'jeetsukumaran/vim-python-indent-black' },

  -- Python types
  { "microsoft/python-type-stubs" },

  -- Python
  -- use 'heavenshell/vim-pydocstring'   -- Overwrites a keymap, need to fix.
  -- use 'bfredl/nvim-ipy'

  -- Markdown
  { 'godlygeek/tabular' },
  { 'ellisonleao/glow.nvim', config = true, cmd = "Glow" },

  -- LaTex
  { 'lervag/vimtex' },

  -- TOML Files
  { 'cespare/vim-toml' },

  -- Poetry
  -- use({'petobens/poet-v',
  --   config = function()
  --     local path = vim.fn.stdpath('config')..'/lua/plugins/poet-v.vim'
  --     vim.cmd('source '..path)
  --   end
  -- })

  -- kitty config syntax-highlight
  { "fladson/vim-kitty" },

  -- note taking with zettelkasten

  -- useless plugin
  { 'eandrju/cellular-automaton.nvim' }
}

require('lazy').setup(plugins)
