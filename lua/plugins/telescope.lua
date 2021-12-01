local actions = require('telescope.actions')
-- local utils = require('telescope.utils')
-- local trouble = require('telescope.providers.telescope')

require('telescope').setup({
  defaults = {
    -- layout_strategy = 'bottom_pane',
    -- pickers = {
    --   find_files = {
    --     theme = 'dropdown',
    --   },
    -- },
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

require('telescope').load_extension('fzf')
