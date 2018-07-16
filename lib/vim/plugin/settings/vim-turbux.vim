" assign custom mappings
let g:no_turbux_mappings = 1
" custom mappings
nmap <leader>r <Plug>SendTestToTmux
nmap <leader>R <Plug>SendFocusedTestToTmux
" use custom turbux runner
let g:turbux_custom_runner = 'TurbuxCustomRunner'
function! TurbuxCustomRunner(command)
  if exists('g:VimuxRunnerIndex')
    unlet g:VimuxRunnerIndex
  endif
  call VimuxClearRunnerHistory()
  call VimuxRunCommand(a:command)
endfunction
" clear screen and shrink prompt before each test
let g:turbux_command_prefix='shrink;'
