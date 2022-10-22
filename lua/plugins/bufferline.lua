local status, bufferline = pcall(require, "bufferline")
if (not status) then return end


-- format as "<id>. <file-name>"
local tabname_format = function(opts)
  return string.format('%s.', opts.ordinal)
end

bufferline.setup({
  options = {
    always_show_bufferline = true,
    numbers = tabname_format, -- tabname_format | "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = {'█','█'}, --  "slant" | "thick" | "thin" | "padded_slant" | { 'any', 'any' }, { '充', '充' } {'⏽','⏽'}
    -- Don't show bufferline over vertical, unmodifiable buffers
    offsets = { {
      filetype = 'NvimTree',
      text = 'File Explorer',
      highlight = 'Directory'
    } },
    custom_areas = {
      right = function()
        local result = { { text = "Buffers", fg = "#ffffff" } }
        return result
      end,
    },
  },
  -- Don't use italic on current buffer
  highlights = {
    fill = {
      ctermbg = 7,
      ctermfg = 0,
    },
    buffer_selected = {
      --fg = normal_fg,
      --bg = '#061124',
      bold = true,
      italic = false,
    },
  },
})
