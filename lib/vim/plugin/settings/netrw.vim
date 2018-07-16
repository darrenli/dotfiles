" set default listing style:
" 0: thin listing (one file per line)
" 1: long listing (one file per line with time stamp information and file size)
" 2: wide listing (multiple files in columns)
" 3: tree style listing
let g:netrw_liststyle = 0

" file exclusion list:
let g:netrw_list_hide = '^\..*\.swp$,^\.DS_Store$'

" syntax highlight special files
let g:netrw_special_syntax = 1
