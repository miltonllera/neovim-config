return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		local non_language_ft = { "fugitive", "startify" }

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = "tokyonight",
				-- Separators might look weird for certain fonts (eg Cascadia)
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				--refresh = {
				--statusline = 5000,
				--tabline = 5000,
				--winbar = 5000,
				--},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" }, -- 'diff', 'diagnostics' -- generate a freezz issue in windows 10
				lualine_c = {
					"filetype",
					{
						function()
							local msg = "No LSP"
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()

							if next(clients) == nil then
								return msg
							end

							-- Check for utility buffers
							for ft in non_language_ft do
								if ft:match(buf_ft) then
									return ""
								end
							end

							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes

								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									-- return 'LSP:'..client.name  -- Return LSP name
									return "" -- Only display if no LSP is found
								end
							end

							return msg
						end,
						color = { fg = "#ffffff", gui = "bold" },
						separator = "",
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
						symbols = { error = "   ", warn = "   ", hint = "   ", info = "   " },
					},
				},
				lualine_x = {
					{
						"filename",
						path = 1,
					},
					"encoding",
				},
				lualine_y = { "progress" },
				lualine_z = {
					{
						function()
							return ""
						end,
					},
					{ "location" },
				},
			},
		})
	end,
}
