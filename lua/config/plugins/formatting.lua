return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local slow_format_filetypes = {}
		
		-- Optimizaciones para archivos grandes
		local max_filesize_format = 500 * 1024 -- 500KB para formateo normal
		local max_filesize_heavy = 200 * 1024  -- 200KB para formateadores pesados como prettier
		local max_lines_format = 3000          -- Máximo número de líneas para formateo

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				["*"] = { "codespell" }, -- spell-checking for all filetypes
			},
			
			-- Formateo con optimizaciones de rendimiento
			format_on_save = function(bufnr)
				-- No formatear si el buffer no está cargado o si estamos en modo diff
				if not vim.api.nvim_buf_is_loaded(bufnr) or vim.wo.diff then
					return
				end
				
				-- Obtener información del archivo
				local file_path = vim.api.nvim_buf_get_name(bufnr)
				if file_path == "" then
					return -- No formatear buffers sin nombre
				end
				
				-- Verificar tamaño del archivo
				local ok, stats = pcall(vim.loop.fs_stat, file_path)
				if not ok or not stats then
					return
				end
				
				-- Verificar si es un archivo grande
				if stats.size > max_filesize_format then
					vim.notify("Archivo demasiado grande para formateo automático", vim.log.levels.INFO)
					return
				end
				
				-- Verificar cantidad de líneas
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				if line_count > max_lines_format then
					vim.notify("Archivo con demasiadas líneas para formateo automático", vim.log.levels.INFO)
					return
				end
				
				-- Verificar si es un formateador pesado como prettier para archivos que podrían ser problemáticos
				local filetype = vim.bo[bufnr].filetype
				if (filetype == "javascript" or filetype == "typescript" or 
					filetype == "javascriptreact" or filetype == "typescriptreact") and 
					stats.size > max_filesize_heavy then
					vim.notify("Archivo TypeScript/JavaScript grande - omitiendo formateo automático", vim.log.levels.INFO)
					return
				end
				
				-- Verificar si el formateo fue lento previamente
				if slow_format_filetypes[filetype] then
					return
				end
				
				-- Función para manejar errores de timeout
				local function on_format(err)
					if err and err:match("timeout$") then
						slow_format_filetypes[filetype] = true
						vim.notify("Formateo lento detectado para " .. filetype .. ". Desactivado para futuras operaciones.", vim.log.levels.WARN)
					end
				end

				return { 
					timeout_ms = 1000, -- Timeout más corto para mejorar rendimiento
					lsp_fallback = true,
				}, on_format
			end,

			-- Para archivos que se han marcado como lentos, formatar después de guardar
			format_after_save = function(bufnr)
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { 
					lsp_fallback = true,
					timeout_ms = 3000 -- Tiempo de espera más largo para formateo post-guardado
				}
			end,
			
			-- Configuración de formateadores específicos con optimizaciones
			formatters = {
				prettier = {
					-- Usar prettier más eficientemente
					env = {
						PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc"),
					},
					-- Usar el daemon de prettier para mejor rendimiento
					command = "prettierd",
					args = { "$FILENAME" },
					range_args = function()
						return { "$FILENAME", "--range-start", "$START", "--range-end", "$END" }
					end,
				},
				shfmt = {
					prepend_args = { "-i", "2", "-ci" },
				},
				stylua = {
					prepend_args = { "--config-path", vim.fn.expand("~/.config/nvim/utils/linter-config/stylua.toml") },
				},
				black = {
					prepend_args = { "--line-length", "88", "--quiet" },
				},
				codespell = {
					-- Solo verificar errores obvios, no usar el diccionario completo para mejorar rendimiento
					args = { "--check-hidden", "--builtin", "clear,rare,code", "-" },
				},
			},
		})

		-- Atajos de teclado optimizados
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local file_path = vim.api.nvim_buf_get_name(bufnr)
			
			-- Verificar tamaño antes de formatear manualmente
			local ok, stats = pcall(vim.loop.fs_stat, file_path)
			if ok and stats and stats.size > max_filesize_format then
				vim.notify("Archivo demasiado grande para formateo: " .. math.floor(stats.size / 1024) .. "KB", vim.log.levels.WARN)
				return
			end
			
			-- Formatear con un timeout más generoso para formato manual
			conform.format({
				bufnr = bufnr,
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Mantener el atajo antiguo por compatibilidad
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
