require("mason").setup()
require "lsp_signature".setup()

local lsp = require("lsp-zero")
--local mason_lspconfig = require("mason-lspconfig")
--local lspconfig = require("lspconfig")
--local common_on_attach = require("lsp.utils").common_on_attach

-- add capabilities from nvim-cmp
--local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable language servers with common settings
local servers = {"bashls", "clangd", "pyright", "jsonls", "tsserver", "yamlls", "cssls" ,"cssmodules_ls","html", "dockerls"}

lsp.preset("recommended")

lsp.setup_servers(servers)

require('lsp.sumneko')

-- Fix Undefined global 'vim'
--lsp.configure('lua-language-server', {
    --settings = {
        --Lua = {
            --diagnostics = {
                --globals = { 'vim' }
            --}
        --}
    --}
--})

--
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
-- signature help hover
--require "lsp_signature".setup({ })
--
--mason_lspconfig.setup({
  --ensure_installed = servers,
--})

--mason_lspconfig.setup_handlers({
  --function (server_name)
    --lspconfig[server_name].setup {
      --on_attach = common_on_attach,
      --capabilities = capabilities,
    --}
  --end
--})

--require("typescript").setup({
  --disable_commands = false, -- prevent the plugin from creating Vim commands
  --debug = false, -- enable debug logging for commands
  --go_to_source_definition = {
      --fallback = true, -- fall back to standard LSP definition on failure
  --},
  --server = { -- pass options to lspconfig's setup method
      --on_attach = common_on_attach,
  --},
--})

-- suppress error messages from lang servers
--vim.notify = function(msg, log_level, _opts)
  --if msg:match("exit code") then
      --return
  --end
  --if log_level == vim.log.levels.ERROR then
      --vim.api.nvim_err_writeln(msg)
  --else
      --vim.api.nvim_echo({{msg}}, true, {})
  --end
--end

--vim.lsp.buf.format({ timeout_ms = 5000 }) -- 3 seconds


