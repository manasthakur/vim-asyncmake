" Vim-AsyncMake
" AUTHOR: Manas Thakur (manasthakur17@gmail.com)
" VERSION: 3.1
" LICENSE: MIT

" Exit if asyncmake is already loaded
if exists("g:loaded_asyncmake")
	finish
endif
let g:loaded_asyncmake = 1

augroup asyncmake
	autocmd!
augroup END

" Define a 'AsyncMake' command (background build with a bang)
command! -bang -nargs=* -complete=file AsyncMake call asyncmake#AsyncMake(<q-args>, '<bang>')

" Define a 'AsyncMakeMonitor' command to enable/disable continuous background builds
command! -bang -nargs=0 AsyncMakeMonitor call asyncmake#AsyncMakeMonitor('<bang>')
