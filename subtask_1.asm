; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha

    ;; recursive qsort implementation goes here

    ; ebx = buff
    mov ebx, [ebp + 8]
    ; ecx = start (low)
    mov ecx, [ebp + 12]
    ; edx = end (high)
    mov edx, [ebp + 16]

    cmp ecx, edx
    ; if start >= end, jump to end function, else continue
    jge end

call_partition:
    ; save registers so as not to be altered in partition function
    push edx
    push ecx
    push ebx

    ; push end
    push edx
    ; push start
    push ecx
    ; push buff
    push ebx
    call partition
    ; cleanup arguments on stack
    add esp, 12

    pop ebx
    pop ecx
    pop edx

end_call_partition:
    ; eax now contains the pi (result of partition)
    ; edi = pivot_index
    mov edi, eax
    ; edi = new_end = pivot_index - 1
    sub edi, 1


sort_left:
    ; recursively sort left partition

    ; save all registers
    pusha

    ; push new_end
    push edi
    ; push start
    push ecx
    ; push buff
    push ebx
    call quick_sort
    ; cleanup arguments on stack
    add esp, 12

    ; restore all registers
    popa

sort_right:
    ; recursively sort right partition

    ; edi = new_start = pivot_index + 1
    add edi, 2

    ; save all registers
    pusha

    ; push end
    push edx
    ; push new_start
    push edi
    ; push buff
    push ebx
    call quick_sort
    ; cleanup arguments on stack
    add esp, 12

    ; restore all registers
    popa

end:
    ; restore the preserved registers
    popa

    leave
    ret




    ; partition function
partition:

    ; create the new stack frame
    enter 0, 0

    ; ebx = buff
    mov ebx, [ebp + 8]
    ; ecx = start (low)
    mov ecx, [ebp + 12]
    ; edx = end (high)
    mov edx, [ebp + 16]

    ; esi = pivot ( buff[end] )
    mov esi, dword [ebx + 4 * edx]

    mov eax, ecx
    ; eax = start - 1 = i
    sub eax, 1

loop_start:
    ; ecx = j
    cmp ecx, edx
    ; if j > end
    jg loop_end

    ; edi = buff[j]
    mov edi, dword [ebx + 4 * ecx]
    cmp edi, esi
    ; if buff[j] >= pivot just increment j
    jge inc_j

    ; eax = i++
    inc eax

    ; preserve edi and esi
    push edi
    push esi

    ; swap buff[i], buff[j]
    ; edi = buff[i]
    mov edi, dword [ebx + 4 * eax]
    ; esi = buff[j]
    mov esi, dword [ebx + 4 * ecx]
    ; buff[i] = buff[j]
    mov [ebx + 4 * eax], esi  
    ; buff[j] = buff[i]          
    mov [ebx + 4 * ecx], edi            

    ; restore edi and esi
    pop esi
    pop edi

inc_j:
    ; j++
    inc ecx
    jmp loop_start

loop_end:
    ; i = i + 1
    inc eax

    ; swap buff[i], buff[end]
    ; keei in edi = buff[i]
    mov edi, dword [ebx + 4 * eax]
    ; keep in esi = buff[end]
    mov esi, dword [ebx + 4 * edx]
    ; buff[i] = (former) buff[end]
    mov [ebx + 4 * eax], esi
    ; buff[end] = (former) buff[i] 
    mov [ebx + 4 * edx], edi  

    leave
    ret
