; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push edi
    push esi

    ; b_search(int32_t *buff, uint32_t needle, uint32_t start, uint32_t end);
    ;; recursive bsearch implementation goes here

    ; ecx = buff
    ; edx = needle

    ; esi = start
    mov esi, [ebp + 8]
    ; edi = end
    mov edi, [ebp + 12]

base_case:
    cmp esi, edi
    jg not_found

middle:
    ; middle = start + (end-start) / 2
    ; eax = start
    mov eax, esi
    ; ebx = end
    mov ebx, edi
    ; ebx = end - start
    sub ebx, eax
    ; ebx = (end - start) / 2
    shr ebx, 1
    ; eax = middle
    add eax, ebx

    ; ebx = buff[middle]
    mov ebx, [ecx + eax * 4]
    cmp ebx, edx
    je found
    ; if buff[middle] < needle search_upper
    jl search_upper
    ; if buff[middle] > needle search_lower
    jg search_lower

search_lower:
    ; edi = middle (end = middle)
    mov edi, eax
    ; search in [start, middle - 1]
    dec edi

    ; recursive call
    push esi
    push edi
    push edx
    push ecx

    ; save new indexes on stack to have as parametres for recursive call
    push edi
    push esi

    call binary_search

    ; clean up stack after recursive call
    add esp, 8

    pop ecx
    pop edx
    pop edi
    pop esi
    jmp my_end

search_upper:
    ; esi = middle (start = middle)
    mov esi, eax
    ; search in [middle + 1, end]
    inc esi

    ; recursive call
    push esi
    push edi
    push edx
    push ecx

    ; save new indexes on stack to have as parametres for recursive call
    push edi
    push esi

    call binary_search

    ; clean up stack after recursive call
    add esp, 8

    pop ecx
    pop edx
    pop edi
    pop esi
    jmp my_end

found:
    ; eax is already middle (the position to return)
    jmp my_end

not_found:
    ; the number was not found
    mov eax, -1

    ;; restore the preserved registers
my_end:
    pop esi
    pop edi
    pop ebx

    leave
    ret
