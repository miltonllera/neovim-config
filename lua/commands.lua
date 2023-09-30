-- Define commands

-- Remove trailing white spaces
-- (if a file requires trailing spaces, exclude its type using the regex)
--vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]


-- CSS autocomplete
vim.cmd [[autocmd FileType css set omnifunc=csscomplete#CompleteCSS]]

-- Swap folder
--vim.cmd('command! ListSwap split | enew | r !ls -l ~/.local/share/nvim/swap')
--vim.cmd('command! CleanSwap !rm -rf ~/.local/share/nvim/swap/')

-- Open help tags
vim.cmd("command! HelpTags Telescope help_tags")

-- Create ctags
vim.cmd('command! MakeCTags !ctags -R --exclude=@.ctagsignore .')

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]] ,
  false
)
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]



