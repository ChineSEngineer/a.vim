function! s:GetTargetFiles()
    let l:file_path = split(expand('%:p'), '\.')
    let l:file_path_without_extension = file_path[0]
    let l:file_path_extension = file_path[1]
    let l:tagets = []
    if file_path_extension == 'cpp' || file_path_extension == 'cc'
        let l:targets = [file_path_without_extension . '.h']
    elseif file_path_extension == 'h'
        let l:targets = [file_path_without_extension . '.cc', file_path_without_extension . '.cpp']
    else
		echohl ErrorMsg
        echo 'Error: file type not correct'
		echohl NONE
        return []
    endif
    return targets
endfunction

function! s:JumpToTarget(targets, operation)
    for l:target in a:targets
        if filereadable(l:target)
            if a:operation == 'edit'
                execute "edit " . target
            elseif a:operation == 'sp'
                execute "sp " . target
            elseif a:operation == 'vs'
                execute "vs " . target
            endif
            break
        endif
    endfor
endfunction

function! AlterHeaderSource(operation)
    let l:targets = s:GetTargetFiles()
    call s:JumpToTarget(l:targets, a:operation)
endfunction


:command! A :call AlterHeaderSource('edit')
:command! AS :call AlterHeaderSource('sp')
:command! AV :call AlterHeaderSource('vs')
