" Custom terminal functions
let t:floaterm_shell_opened = 0
let t:floaterm_ranger_opened = 0
let t:floaterm_lazygit_opened = 0
let t:floaterm_oneshot_opened = 0

function! CustomTermToggle(cmd)
	if a:cmd == g:floaterm_shell && t:floaterm_shell_opened == 1
		exe 'FloatermToggle '.a:cmd
	elseif a:cmd == 'ranger' && t:floaterm_ranger_opened == 1
		exe 'FloatermToggle ranger'
	elseif a:cmd == 'lazygit' && t:floaterm_lazygit_opened == 1
		exe 'FloatermToggle lazygit'
	else
		exe 'FloatermNew --autoclose=2 --name='.a:cmd.' --title='.a:cmd.' '.a:cmd
	endif
endfunction

function! CustomOneShotTerm(cmd)
	if t:floaterm_oneshot_opened
		exe 'FloatermSend --name=oneshot'.a:cmd
	else
		exe 'FloatermNew --height=0.8 --width=0.6 --name=oneshot --title=oneshot'.a:cmd
	endif
endfunction

function! CustomTermOpenHandler()
	if get(b:, 'floaterm_title', 1) == 1
		return
	endif

	if b:floaterm_title == g:floaterm_shell
		let t:floaterm_shell_opened = 1
	elseif b:floaterm_title == 'ranger'
		let t:floaterm_ranger_opened = 1
	elseif b:floaterm_title == 'lazygit'
		let t:floaterm_lazygit_opened = 1
	elseif b:floaterm_title == 'oneshot'
		let t:floaterm_oneshot_opened = 1
	endif
endfunction
function! CustomTermCloseHandler()
	if get(b:, 'floaterm_title', 1) == 1
		return
	endif

	if b:floaterm_title == g:floaterm_shell
		let t:floaterm_shell_opened = 0
	elseif b:floaterm_title == 'ranger'
		let t:floaterm_ranger_opened = 0
	elseif b:floaterm_title == 'lazygit'
		let t:floaterm_lazygit_opened = 0
	elseif b:floaterm_title == 'oneshot'
		let t:floaterm_oneshot_opened = 0
	endif
endfunction
augroup customTermAutocmds
	autocmd!
	autocmd TermOpen * :call CustomTermOpenHandler()
	autocmd TermClose * :call CustomTermCloseHandler()
augroup END

