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

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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

  -- completion = {
  --   autocomplete = false,
  --   completeopt = vim.o.completeopt,
  -- },

  experimental = {
    ghost_text = true,
  },

  -- Snippet engine, required
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Mappings
  mapping = {
    -- open/close autocomplete
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        elseif cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        end
      end, {
        "i",
        "s",
      }),
    -- ['<C-Space>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.close()
    --   else
    --     cmp.complete()
    --   end
    -- end,

    -- ['<Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end,

    -- ['<S-Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end,

    ['<C-c>'] = cmp.mapping.close(),

    -- select completion
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),

    -- Scroll documentation
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  },

  -- Complete options from the LSP servers and the snippet engine
  sources = {
    {name = 'nvim_lsp',  priority = 3},
    {name = 'luasnip',  priority = 1},
    -- {name = "copilot", group_index = 2, priority = 3},

    {name = 'path' },
    {name = 'buffer' },
    -- {name = 'nvim_lua', group_index = 2},
    -- {name = 'spell', group_index = 2},
    -- {name = 'calc'},
  },
})

-- Disable copilot in cmp popup
cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
  end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

-- Proper sources for buffer and cmdline
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
