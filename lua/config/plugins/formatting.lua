return {
  -- General
  { 'michaeljsmith/vim-indent-object' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-commentary' },
  { 'junegunn/vim-easy-align' },
  { 'godlygeek/tabular', lazy = true, },

  -- Python
  { "EgZvor/vim-black", lazy = true,},
  { 'jeetsukumaran/vim-python-indent-black', lazy = true, },
  { "microsoft/python-type-stubs", lazy = true, },

  -- Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    main='render-markdown',
    name='render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
  },
  { 'ellisonleao/glow.nvim', config = true, cmd = "Glow",  lazy = true, },

  -- LaTex
  { 'lervag/vimtex', lazy = true, init =  function () vim.g.vimtex_view_method="zathura" end },

  -- TOML Files
  { 'cespare/vim-toml', lazy = true, },

  -- kitty config syntax highlighting
  { "fladson/vim-kitty", lazy = true, },
}
