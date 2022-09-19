local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

--local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,

  sources = {
    sources = {
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = '[eslint] #{m}\n(#{c})'
      }),
      null_ls.builtins.diagnostics.fish
    },
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--semi", "--single-quote", "--jsx-single-quote" },
    },
   
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.google_java_format,
    diagnostics.flake8,
    formatting.isort, 
    -- formatting.codespell.with({filetypes = {'markdown',  'typescript', 'typescriptreact'}}),
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.completion.spell,
  },
  --on_attach = function(client)
  --  if client.server_capabilities.document_formatting then
  --    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
  --  end
  --  vim.cmd [[
  --    augroup document_highlight
  --      autocmd! * <buffer>
  --      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --    augroup END
  --  ]]
  -- end
}

-- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()