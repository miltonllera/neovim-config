return {
  "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    -- "saghen/blink.cmp",
  },
  config = function()
    -- import mason and mason_lspconfig
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_enable = false,
      -- servers for mason to install
      ensure_installed = {
        "lua_ls",
        "bashls",
        "basedpyright",
        "julials",
        "texlab",
        "marksman",
      },

    })

    mason_tool_installer.setup({
      ensure_installed = {
        "pylint",
        "clangd",
      },
    })
  end,
}
