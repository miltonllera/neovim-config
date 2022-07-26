" Poet-v
"
let g:poetv_executables = ['poetry', 'pipenv']
let g:poetv_auto_activate = 1
let g:poetv_statusline_symbol = ''
let g:poetv_set_environment = 1

augroup poetv_autocmd
  au!
  au WinEnter,BufWinEnter *.py
    \ if &previewwindow != 1 && expand('%:p') !~# "/\\.git/" |
      \ call poetv#activate() | call ale#lsp#reset#StopAllLSPs() |
    \ endif
augroup END
