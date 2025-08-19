return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function ()
      require("copilot").setup(
        {
          -- Disable ghost suggestions
          panel = { enabled =  false, },
          suggestion = { enabled = false, },
        }
      )

      vim.g.copilot_filetypes = {
          ["*"] = false,
          ["python"] = true,
          ["julia"] = true,
          ["bash"] = true,
        }

      local suggestion = require("copilot.suggestion")

      vim.keymap.set("i", "<M-SPACE>",
        function()
          if suggestion.is_visible() then
            suggestion.accept()
          else
            suggestion.next()
          end
        end,
        { desc ="[copilot] accept or next suggestion" }
      )
    end
  },

  -- To enable using Copilot with nvim-cmp
  {
    'zbirenbaum/copilot-cmp',
    config = function ()
      local cmp = require("copilot_cmp")
      local unpack = table.unpack or unpack
      local has_words_before = function()
        if vim.api.nvim_buf_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end
      cmp.setup({
        mapping = {
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        },
      })
    end
  }
}
