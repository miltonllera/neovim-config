-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone','https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load Packer
cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime pluggins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').init({
    max_jobs = 20,
})

-- Initialize pluggins
return require('packer').startup(function(use)
  -- provided appimage.
  use 'lewis6991/impatient.nvim'
  
  -- Let Packer manage itself
  use({'wbthomason/packer.nvim', opt = true})
  


  -- Helper for installing most language servers and LSP server
  use ({
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig'
    },
    config = function()
      -- lsp lang specific config
      require('plugins.lspconfig') 
    end,
    event = 'BufRead',
  })

  
  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    -- Sources for nvim-cmp
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      'hrsh7th/nvim-compe',
      "f3fora/cmp-spell",
    },
    config = function() require('plugins.cmp') end,
  })


  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end,
    run = ':TSUpdate'
  })

  -- Snippets
  use {"L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end}
  use "rafamadriz/friendly-snippets"

  -- Signature help
  use "ray-x/lsp_signature.nvim"

  -- make by yourself
  -- choco install make and make the file: make -f <makefile> for windows
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
     run ='make',
    })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {{
      'nvim-lua/plenary.nvim'
    }},
    config = function() require('plugins.telescope') end,
    event = 'CursorHold',
  })

  

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  })

  -- statusline
  use({
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  })

  -- NvimTree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.nvimtree') end,  -- Must add this manually
  })

  -- Startify
  use({
    'mhinz/vim-startify',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/startify.vim'
      vim.cmd('source '..path)
    end
  })

  -- git commands
  use 'tpope/vim-fugitive'

  -- Gitsigns
  use ({
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('plugins.gitsigns') end
  })

  -- Formatting
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'junegunn/vim-easy-align'

  -- Python formatting
  --use "EgZvor/vim-black"
  --use 'jeetsukumaran/vim-python-indent-black'



  -- Markdown
  use 'godlygeek/tabular'
  use 'ellisonleao/glow.nvim'

  -- TOML Files
  use 'cespare/vim-toml'

  -- kitty config syntax-highlight
  use "fladson/vim-kitty"

  -- note taking with zettelkasten

  -- Themes
  --use 'ghifarit53/tokyonight-vim'
  use 'folke/tokyonight.nvim'

  use 'marko-cerovac/material.nvim'

  -- Auto load doc
  use 'djoshea/vim-autoread'
  
  -- Auto comment text
  use 'scrooloose/nerdcommenter' 

  -- Multicursors
  use({
    'mg979/vim-visual-multi',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/vim-visual-multi.vim'
      vim.cmd('source '..path)
    end
  })


  use { 'norcalli/nvim-colorizer.lua', config = function() require('plugins.colorizer') end, event = "BufRead" }
  use { 'p00f/nvim-ts-rainbow', after = "nvim-treesitter" }
  use { 'windwp/nvim-autopairs', config = function() require('plugins.autopairs') end, after = "nvim-cmp" }

 
 -- for formatters and linters 
  use ({
    'dense-analysis/ale',
    config = function()
     local path = vim.fn.stdpath('config')..'/lua/plugins/ale.vim'
      vim.cmd('source '..path)
     end,
     after = "nvim-treesitter"
   })

  use {
    'lewis6991/spellsitter.nvim',
    config = function() require('plugins.spellsitter') end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
