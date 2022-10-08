" Startify


"enable copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Don't show [e] and [q] options
let g:startify_enable_special = 0

" Change directory when opening file using Startify
let g:startify_change_to_dir  = 1  " This is the default value

" Add bashrc and nvim config files
let g:startify_bookmarks = [
          \ {'h': 'C:\Code\hpx-winclient'},
          \ {'m': 'C:\Code\win-app-comcent'},
          \ {'p': 'C:\Proj'},
          \ {'n': '~/AppData/Local/nvim'}
          \ ]

" Change list order
let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Recent Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]


" Python
let g:python3_host_prog = 'C:\Python310\python.exe'
set pyxversion=3
set pyx=3
set switchbuf+=uselast


" native autocomplete and sintax check disable
if exists("syntax_on")
    syntax reset
endif

set backupdir=~/.backup

"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

"" nvim_treesitter
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()






