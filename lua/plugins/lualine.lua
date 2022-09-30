-- Lualine configuration
local status, lualine = pcall(require, "lualine")
if (not status) then return end

local non_language_ft = {'fugitive', 'startify'}

lualine.setup({
  options = {
    --theme = "tokyonight",
    -- Separators might look weird for certain fonts (eg Cascadia)
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    globalstatus = true,
    refresh = {
      statusline = 5000,
      tabline = 5000,
      winbar = 5000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff'}, -- 'diff', 'diagnostics' -- generate a freezz issue
    lualine_c = {
      'filetype',
      {
        function()
          local msg = 'No LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()

          if next(clients) == nil  then
            return msg
          end

          -- Check for utility buffers
          for ft in non_language_ft do
            if ft:match(buf_ft) then
              return ''
            end
          end

          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes

            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              -- return 'LSP:'..client.name  -- Return LSP name
              return ''  -- Only display if no LSP is found
            end
          end

          return msg
        end,
        color = {fg = '#ffffff', gui = 'bold'},
        separator = "",
      },
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        sections = {'error', 'warn', 'info'},
      },
    },
    lualine_x = {'encoding'},
    lualine_y = {'progress'},
    lualine_z = {
      {function () return '' end},
      {'location'},
    }
  },
})
