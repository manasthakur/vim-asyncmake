" Vim-AsyncMake
" AUTHOR: Manas Thakur (manasthakur17@gmail.com)
" VERSION: 2.1
" LICENSE: MIT

" Exit if asyncmake is already loaded
if exists("g:loaded_asyncmake")
	finish
endif
let g:loaded_asyncmake = 1

" Define a 'AsyncMake' command
command! -bang -nargs=* -complete=file AsyncMake call asyncmake#AsyncMake(<q-args>, '<bang>')
