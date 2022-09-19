" Ale config

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}

let g:ale_linters_ignore = {
  \   'javascript': ['eslint'],
  \   'css': ['eslint'],
  \   'typescript': ['eslint'],
  \   'typescriptreact': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 0
let g:ale_sign_error = '窱'
let g:ale_sign_warning = ''

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" if you don't want linters to run on opening a file

let g:ale_lint_on_enter = 0

"let g:ale_javascript_prettier_use_local_config = 1


