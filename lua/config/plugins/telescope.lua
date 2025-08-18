return {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- using master to fix issues with deprecated to definition warnings
      -- '0.1.x' for stable ver.
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function ()
      local telescope = require("telescope")
		  local actions = require("telescope.actions")
		  -- local builtin = require("telescope.builtin")

      telescope.load_extension('fzf')

      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-c>'] = actions.close,
            },
            n = {
              ['<C-c>'] = actions.close,
            },
          },
          layout_config = {
            horizontal ={
              height = 47,
              prompt_position = "top",
            }
          }
        },
        extensions ={
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                               -- the default case_mode is "smart_case"
            },
          },
      })

      -- Telescope-specific keymaps
      local utils = require("utils")

      utils.nnoremap("<leader>o", "<Cmd>Telescope find_files<CR>")
      utils.nnoremap("<leader>H", "<Cmd>Telescope find_files hidden=true<CR>")
      utils.nnoremap("<leader>b", "<Cmd>Telescope buffers<CR>")
      utils.nnoremap("<leader>lg", "<Cmd>Telescope live_grep<CR>")
      utils.nnoremap(
        "<leader>pr", "<cmd>Telescope oldfiles<CR>" -- Fuzzy find recent files
      )

    end
}
