" Vim-AsyncMake
" AUTHOR: Manas Thakur (manasthakur17@gmail.com)
" VERSION: 2.1
" LICENSE: MIT

" Function to build (async for Vim 8+)
function! asyncmake#AsyncMake(cmd, cmdbang) abort
	if !empty(a:cmd)
		let b:asyncmakeprg = a:cmd
	elseif empty(b:asyncmakeprg)
		let b:asyncmakeprg = "make"
	endif
	if v:version >= 800
		" The async version (Vim 8+)
		echo "Running: " . b:asyncmakeprg
		let s:asyncmake_outfile = tempname()
		if a:cmdbang  == ''
			call job_start(b:asyncmakeprg, {'exit_cb': 'ExitHandler1', 'err_io': 'file', 'err_name': s:asyncmake_outfile})
		else
			call job_start(b:asyncmakeprg, {'exit_cb': 'ExitHandler2', 'err_io': 'file', 'err_name': s:asyncmake_outfile})
		endif
	else
		" The synchronous version
		let &makeprg = b:asyncmakeprg
		execute "silent make!" | redraw!
	endif
endfunction

" Functions to handle job-exit (Vim 8+)
function! ExitHandler1(job, exit_status) abort
	execute "cgetfile " . s:asyncmake_outfile
	echo ""
	belowright cwindow
	if a:exit_status == 0
		echo "No errors!"
	endif
endfunction

function! ExitHandler2(job, exit_status) abort
	execute "cgetfile " . s:asyncmake_outfile
	if a:exit_status == 0
		execute "cclose"
		echo ""
	else
		redraw!
	endif
endfunction

" Function to display the number of errors+warnings in the statusline
function! asyncmake#statusline() abort
	let l:len_qflist = len(filter(getqflist(), 'v:val.valid'))
	if l:len_qflist != 0
		return "[" . len_qflist . "]"
	else
		return ""
	endif
endfunction
