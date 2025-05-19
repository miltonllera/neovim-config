return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				-- ensure these language parsers are installed
				ensure_installed = {},
				sync_install = false, -- No instalar parsers en cada arranque
				auto_install = false, -- Desactivar instalación automática para controlar mejor
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				parser_install_dir = vim.fn.stdpath("data") .. "/treesitter_cache",
			})

			-- Configuración recomendada para ts_context_commentstring (fuera de nvim-treesitter)
			pcall(function()
				require('ts_context_commentstring').setup {}
			end)
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},
}
