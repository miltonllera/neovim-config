return {
  'kyazdani42/nvim-tree.lua',
  dependencies = 'kyazdani42/nvim-web-devicons',
  config = function()
    local nvimtree = require("nvim-tree")
    local utils = require("utils")

    nvimtree.setup({
      -- Allow using gx
      disable_netrw = false,
      hijack_netrw = false,
      update_cwd = true,

      actions = {
          open_file = {
              window_picker = {
                  enable = false,
              },
          },
      },

      filters = {
          custom = { ".DS_Store" },
      },

      git = {
          ignore = false,
      },
    })

    utils.nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")  -- NvimTree
  end
}
