-- Visual
vim.o.conceallevel       = 0  -- Don't hide quotes in markdown
vim.o.cmdheight          = 1
vim.o.pumheight          = 10
vim.o.showtabline        = 2
vim.o.title              = true
vim.o.termguicolors      = true  -- Necessary for some plugins (eg. bufferline)
vim.wo.number            = true
vim.wo.relativenumber    = true
vim.wo.signcolumn        = 'yes'
vim.wo.cursorline        = true

-- Behaviour
vim.o.smarttab           = true
vim.o.tabstop            = 2
vim.o.softtabstop        = 2
vim.o.shiftwidth         = 2
vim.o.smartindent        = true
vim.o.splitbelow         = true
vim.o.splitright         = true
vim.o.expandtab          = true
vim.o.mouse              = 'a'

-- Vim specific
vim.o.hidden             = true  -- Do not save when switching buffers
vim.o.fileencoding       = "utf-8"
vim.o.spelllang          = 'en'
vim.o.completeopt        = "menuone,noselect"
vim.o.updatetime         = 100

-- Disable default plugins
vim.g.loaded_netrwPlugin = false

-- Disable inline error messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

-- Define commands
vim.cmd('command! MakeTags !ctags -R --exclude=@.ctagsignore .')
