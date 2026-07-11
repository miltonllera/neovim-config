-- Define commands

-- Toggle highlight
-- vim.cmd([[command! HiLiToggle (g:hlsearch ? ':nohls' : ':set hls')]])

-- Remove trailing whitespaces
-- (if a file requires trailing spaces, exclude its type using the regex)
vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]

-- Swap folder
vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/share/nvim/swap')
vim.cmd('command! CleanSwap !rm -rf ~/.local/state/nvim/swap/')

-- Open help tags
vim.cmd("command! HelpTags Telescope help_tags")

-- Create ctags
vim.cmd('command! MakeCTags !ctags -R --exclude=@.ctagsignore .')

-- Quicfix manipulation
vim.api.nvim_create_user_command('QfToAlist', function()
  local qf = vim.fn.getqflist()
  local seen, files = {}, {}
  for _, item in ipairs(qf) do
    if item.bufnr and item.bufnr > 0 then
      local name = vim.fn.bufname(item.bufnr)
      if name ~= '' and not seen[name] then
        seen[name] = true
        table.insert(files, name)
      end
    end
  end
  if #files > 0 then
    vim.cmd('args ' .. table.concat(files, ' '))
  else
    print('No valid files in quickfix list')
  end
end, {})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    desc = 'Attach keymaps for quickfix list',
    callback = function()
        vim.keymap.set('n', 'dd', function()
            local qf_list = vim.fn.getqflist()

            local current_line_number = vim.fn.line('.')

            if qf_list[current_line_number] then
                table.remove(qf_list, current_line_number)

                vim.fn.setqflist(qf_list, 'r')

                local new_line_number = math.min(current_line_number, #qf_list)
                vim.fn.cursor(new_line_number, 1)
            end
        end, {
            buffer = true,
            noremap = true,
            silent = true,
            desc = 'Remove quickfix item under cursor',
        })
    end
})
