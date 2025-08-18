return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                local opts = { buffer = ev.buf, silent = true, noremap = true }

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

                opts.desc = "Rename all"
                vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts)

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "signature help"
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

            end,
        })

        -- Set the diagnostic config
        vim.diagnostic.config({
            virtual_text = false,  -- Specify Enable virtual text for diagnostics
            underline = false,     -- Specify Underline diagnostics
            update_in_insert = false,  -- Keep diagnostics active in insert mode
            signs = true,
        })


        -- Configure servers
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- lua
        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
        vim.lsp.enable('lua_ls')

        -- python
        vim.lsp.config('basedpyright', {
          capabilities = capabilities,
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                typeCheckingMode = 'standard',
                capabilities = capabilities,
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  autoSearchPaths = true,
                  enableTypeIgnoreComments = false,
                  reportGeneralTypeIssues = 'none',
                  reportArgumentType = 'none',
                  reportUnknownMemberType = 'none',
                  reportAssignmentType = 'none',
                },
              },
            },
          },
        })
        vim.lsp.enable('basedpyright')

        -- -- python linter
        -- vim.lsp.config('ruff', {
        --   init_options = {
        --     settings = {
        --       -- Ruff language server settings go here
        --     }
        --   }
        -- })
        -- vim.lsp.enable('ruff')
    end
}
