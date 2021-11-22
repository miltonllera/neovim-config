require('bufferline')

-- format as "<id>. <file-name>"
local tabname_format = function (opts)
  return string.format('%s.', opts.id)
end

require('bufferline').setup({
  options = {
    always_show_bufferline = true,
    numbers = tabname_format,
    show_buffer_icons = true,
    -- Don't show bufferline over vertical, unmodifiable buffers
    offsets = {{
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory'
    }},
  },
  -- Don't use italic on current buffer
  highlights = {buffer_selected = { gui = "bold" },},
})
