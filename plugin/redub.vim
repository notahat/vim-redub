" Vim plugin to move and rename files.
" Author: Pete Yandell <pete@notahat.com>

let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_redub") || &cp
  finish
endif
let g:loaded_redub = 1

command! -nargs=* -complete=file Redub call s:redub(<f-args>)

function! s:redub_buffer(new_name)
  " Make sure errors halt execution.
  try
    let existing_name = bufname("%")

    " Change the name of the current buffer.
    execute "silent keepalt file " . fnameescape(a:new_name)
    silent write

    " Delete the old file.
    call delete(l:existing_name)
  endtry
endfunction

" A smart file move that that handles renaming any open buffers associated
" with the file.
function! s:redub_file(old_name, new_name)
  " Expand the fie names to full paths.
  let l:old_name = fnamemodify(a:old_name, ":p")
  let l:new_name = fnamemodify(a:new_name, ":p")

  " See if we've got a buffer for the file.
  let l:buffer_number = bufnr(l:old_name)

  if l:buffer_number == -1
    " There's no buffer open for the file, so just move it in the file system.
    call rename(l:old_name, l:new_name)
  else
    " Switch to the file's buffer, rename it, then switch back.
    let l:old_buffer_number = bufnr("%")
    exec "silent keepalt buffer " . l:buffer_number
    call s:redub_buffer(a:new_name)
    exec "silent keepalt buffer " . l:old_buffer_number
  endif
endfunction

function! s:redub(...)
  if a:0 == 1
    call s:redub_buffer(a:1)
  elseif a:0 == 2
    call s:redub_file(a:1, a:2)
  end
endfunction

let &cpo = s:save_cpo

