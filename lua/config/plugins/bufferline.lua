return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    event = 'BufWinEnter',
    config = function()

      local bufferline = require("bufferline")
      -- format as "<id>. <file-name>"
      local tabname_format = function (opts)
        return string.format('%s.', opts.ordinal)
      end

      bufferline.setup({
        options = {
          always_show_bufferline = true,
          numbers = tabname_format,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = 'thin',
          -- Don't show bufferline over vertical, unmodifiable buffers
          offsets = {{
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory'
          }},
        },
        -- Don't use italic on current buffer
        highlights = {buffer_selected = { bold = true },},
      })

    end,
  },

}
