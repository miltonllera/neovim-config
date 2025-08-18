return {
  -- General
  { 'tpope/vim-commentary' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'junegunn/vim-easy-align' },

  -- Python
  { "EgZvor/vim-black" },
  { 'jeetsukumaran/vim-python-indent-black' },
  { "microsoft/python-type-stubs" },

  -- Markdown
  { 'godlygeek/tabular' },
  { 'ellisonleao/glow.nvim', config = true, cmd = "Glow" },

  -- LaTex
  { 'lervag/vimtex', lazy = false, init =  function () vim.g.vimtex_view_method="zathura" end },

  -- TOML Files
  { 'cespare/vim-toml' },

  -- kitty config syntax highlighting
  { "fladson/vim-kitty" },
}
