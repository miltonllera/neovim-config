-- Define commands

-- Delete swap folder
vim.cmd('command! CleanSwap !rm -rf ~/.local/share/nvim/swap/')

-- Create ctags
vim.cmd('command! MakeTags !ctags -R --exclude=@.ctagsignore .')
