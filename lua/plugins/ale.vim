" Ale config

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error = '窱'
let g:ale_sign_warning = ''
"let g:ale_javascript_prettier_use_local_config = 1


