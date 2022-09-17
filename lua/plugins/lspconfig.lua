local nvim_lsp = require('lspconfig')
local utils = require('lsp.utils')
local common_on_attach = utils.common_on_attach

-- add capabilities from nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable language servers with common settings
local servers = {"bashls", "clangd", "pyright", "jsonls", "tsserver", "yamlls", "cssls", "html", "dockerls"}
--local servers = {"bashls", "clangd", "pyright", "jsonls",  "yamlls", "cssls", "html", "dockerls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = common_on_attach,
    capabilities = capabilities,
  })
end


require('lsp.sumneko')

-- signature help hover
require "lsp_signature".setup({ })


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