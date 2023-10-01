return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
	nvimtree.setup({
	  -- Allow using gx
	  disable_netrw = false,
	  hijack_netrw = false,
	  update_cwd = true,
	  sort_by = "case_sensitive",
	  sync_root_with_cwd = true,

	  view = {
	    adaptive_size = false,
	    width = 40,
	  },
	  git = {
	    enable = false,
	  },
	  renderer = {
	    group_empty = true,
	    icons = {
	      webdev_colors = true,
	      git_placement = "before",
	      padding = " ",
	      symlink_arrow = " ➛ ",
	      show = {
		file = true,
		folder = true,
		folder_arrow = true,
		git = true,
	      },
	      glyphs = {
		default = "",
		symlink = "",
		bookmark = "",
		folder = {
		  arrow_closed = "",
		  arrow_open = "",
		  --  default = "",
		  --  open = "",
		  default = "",
		  open = "",
		  empty = "",
		  empty_open = "",
		  symlink = "",
		  symlink_open = "",
		},
	      }
	    }
	  },
	  filters = {
	    dotfiles = false,
	  },
	})


    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
