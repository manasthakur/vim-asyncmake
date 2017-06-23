" Vim-AsyncMake
" AUTHOR: Manas Thakur (manasthakur17@gmail.com)
" VERSION: 1.0
" LICENSE: MIT

" Function to run make (async for Vim 8+)
function! asyncmake#AsyncMake(cmd) abort
  if !empty(a:cmd)
    let b:asyncmakeprg = a:cmd
  endif
  if v:version >= 800
    " The Async version (Vim 8+)
    echo "Compiling: " . b:asyncmakeprg
    let s:asyncmake_outfile = tempname()
    call job_start(b:asyncmakeprg, {'exit_cb': 'ExitHandler', 'err_io': 'file', 'err_name': s:asyncmake_outfile})
  else
    " The synchronous version
    let &makeprg = b:asyncmakeprg
    execute "silent make!" | redraw!
  endif
endfunction

" Function to handle job-exit (Vim 8+)
function! ExitHandler(job, exit_status) abort
  execute "cgetfile " . s:asyncmake_outfile
  echo ""
  if a:exit_status == 0
    echo "No errors!"
  endif
  unlet s:asyncmake_outfile
endfunction

" vim: tabstop=2
