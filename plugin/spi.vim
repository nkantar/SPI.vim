" SPI.vim - Sort Python Imports
" Sort Python imports by module/package name
" Maintainer:   Nik Kantar <http://nkantar.com>
" Version:      0.1

" Return selection coordinates
function! s:SPICoordinates()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    return [l:lnum1, l:col1, l:lnum2, l:col2]
endfunction

" Return selected lines
function! s:SPISelect()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1, lnum2, col2] = s:SPICoordinates()
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return lines
endfunction

" Verify selected lines are valid Python imports
function! s:SPIVerify(lines)
    for line in a:lines
        if (line !~ "^from") && (line !~ "^import")
            return 0
        endif
    endfor
    return 1
endfunction

" Compare two lines sans "import" and "from"
function! s:SPICompare(line1, line2)
    let trimmed_line1 = tolower(substitute(substitute(a:line1, "^\s*import\ ", "", ""), "^\s*from\ ", "", ""))
    let trimmed_line2 = tolower(substitute(substitute(a:line2, "^\s*import\ ", "", ""), "^\s*from\ ", "", ""))
    if l:trimmed_line1 < l:trimmed_line2
        return -1
    elseif l:trimmed_line1 > l:trimmed_line2
        return 1
    else
        return 0
    endif
endfunction

" Sort lines
function! s:SPISort(lines)
    let sorted_lines = sort(a:lines, "s:SPICompare")
    return l:sorted_lines
endfunction

" Replace selection with processed lines
function! s:SPIReplace(lines, first_line)
    let line_number = a:first_line
    for line in a:lines
        call setline(line_number, line)
        let line_number = l:line_number + 1
    endfor
endfunction

" Callable
function! g:SPI() range
    let [first_line, first_col, last_line, last_col] = s:SPICoordinates()
    let lines = s:SPISelect()
    let lines_valid = s:SPIVerify(l:lines)
    if l:lines_valid
        let sorted_lines = s:SPISort(l:lines)
        call s:SPIReplace(l:sorted_lines, l:first_line)
    else
        echo "Some of the selected lines aren't valid Python imports. Exiting."
    endif
endfunction

command! -range SPI call g:SPI()
