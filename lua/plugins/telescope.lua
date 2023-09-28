local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
-- local utils = require('telescope.utils')
-- local trouble = require('telescope.providers.telescope')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<C-c>'] = actions.close,
      },
      n = {
        ['<q>'] = actions.close,
      },
    },
    layout_config = {
      horizontal ={
        height = 47,
        prompt_position = "top",
      }
    }
  },
  -- fix delay issues
  pickers = {
    find_files = {
      path_display = { "smart" }
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

-- choco install make and make the file: make -f <makefile>
telescope.load_extension('fzf')
