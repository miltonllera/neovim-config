local fn = vim.fn

-- local Utils = require('utils')
local luasnip = require('luasnip')
local cmp = require('cmp')

-- local exprinoremap = Utils.exprinoremap

local function get_snippets_rtp()
  return vim.tbl_map(function(itm)
    return fn.fnamemodify(itm, ":h")
  end, vim.api.nvim_get_runtime_file(
      "package.json", true
  ))
end

local opts = {
  paths = {
    fn.stdpath('config')..'/snips/',
    get_snippets_rtp()[1],
  },
}

require('luasnip.loaders.from_vscode').lazy_load(opts)

cmp.setup({
  -- Don't autocomplete, otherwise there is too much clutter
  -- completion = {autocomplete = { false },},

  -- Don't preselect an option
  preselect = cmp.PreselectMode.None,

  -- Snippet engine, required
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Mappings
  mapping = {
    -- open/close autocomplete
    ['<C-Space>'] = function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete()
      end
    end,

    ['<C-c>'] = cmp.mapping.close(),

    -- select completion
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),

    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,

    -- Scroll documentation
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },

  -- Complete options from the LSP servers and the snippet engine
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'nvim_lua'},
    {name = 'path'},
    {name = 'buffer'},
    {name = 'spell'},
    -- {name = 'calc'},
  },
})
