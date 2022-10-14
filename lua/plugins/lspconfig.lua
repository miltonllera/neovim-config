local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end


local utils = require('lsp.utils')
local common_on_attach = utils.common_on_attach

-- add capabilities from nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable language servers with common settings
local servers = {"bashls", "clangd", "pyright", "jsonls", "tsserver", "yamlls", "cssls" ,"cssmodules_ls","html", "dockerls"}
--local servers = {"bashls", "clangd", "pyright", "jsonls",  "yamlls", "cssls", "html", "dockerls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = common_on_attach,
    capabilities = capabilities,
    init_options = {
      camelCase = true,
    },
    flags = {
       debounce_text_changes = 150,
    },
  })
end


require('lsp.sumneko')

-- signature help hover
require "lsp_signature".setup({ })

require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
      on_attach = common_on_attach,
  },
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
  if msg:match("exit code") then
      return
  end
  if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
  else
      vim.api.nvim_echo({{msg}}, true, {})
  end
end

--vim.lsp.buf.format({ timeout_ms = 5000 }) -- 3 seconds


