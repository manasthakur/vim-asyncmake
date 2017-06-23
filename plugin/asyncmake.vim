" Vim-AsyncMake
" AUTHOR: Manas Thakur (manasthakur17@gmail.com)
" VERSION: 1.0
" LICENSE: MIT

" Exit if asyncmake is already loaded
if exists("g:loaded_asyncmake")
	finish
endif
let g:loaded_asyncmake = 1

" Define a 'AsyncMake' command
command! -nargs=* -complete=file AsyncMake call asyncmake#AsyncMake(<q-args>)

" vim: tabstop=2
