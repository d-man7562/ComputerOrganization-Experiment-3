;Experiment 3, Domenic Mancuso
section .data
    ; Placeholder for result character
    resultChar dd 0  

    ; reserve 128 bytes for input
    inputBuffer times 128 db 0    
    input1 times 128 db 0 ;operand one
    input2 times 128 db 0 ; operand two
    ;store how many characters are read in successfully
    charsRead dd 0 ;use for initial input
    charsRead1 dd 0 ; use for second input loop
    ;store how many characters are written successfully
    charsWrite dd 0

    ;new line
    newline db 0dh, 0ah, 0
    newlineLen equ $ - newline
    ;promot user for input
    intmsg db "Type in 1 for add operation, 2 for subtract, otherwise input 3 to exit", 0dh, 0ah, 0
    intmsgLen equ $ - intmsg
    charsWrite0 dd 0


    ;add sequence
        addmsg1 db "Enter add operand one:", 0dh, 0ah,0
        addmsg1Len equ $ - addmsg1
        addmsg2 db "Enter add operand two:", 0dh, 0ah, 0
        addmsg2Len equ $ - addmsg2
        addmsg3 db "Calculating from add sequence...", 0dh, 0ah, 0
        addmsg3Len equ $ - addmsg3
        charsWrite1 dd 0
   
   ;subtract sequence
        submsg1 db "Enter subtract operand one:", 0dh, 0ah, 0
        submsg1Len equ $ - submsg1
        submsg2 db "Enter subtract operand two:", 0dh, 0ah, 0
        submsg2Len equ $ - submsg2
        submsg3 db "Calculating from subtract sequence...", 0dh, 0ah, 0
        submsg3Len equ $ - submsg3

        charsWrite2 dd 0

   ;end sequence
        endmsg1 db "Thanks for playing!", 0dh, 0ah, 0
        endmsg1Len equ $ - endmsg1
        charsWrite3 dd 0
    
    
    ;if input isnt 1,2, or 3
        badmsg db "Invalid input, please try again", 0dh, 0ah, 0
        badmsgLen equ $ - badmsg
        charsWrite4 dd 0
section .bss
    ;uninitizalized data if you need
    stdHandle resd 1 
    stdReadHandle resd 1
    stdHandle1 resd 1
    

section .text
    ;write your code here
    extern _GetStdHandle@4, _WriteConsoleA@20, _ExitProcess@4, _ReadConsoleA@20
    global _start

_start:
    ;main function here
    ;prompt user for input
        push -11                      ; STD_OUTPUT_HANDLE constant is -11
        call _GetStdHandle@4
        mov [stdHandle], eax          ; Save the handle

    ; Write the message to standard output
        push 0                        ; Placeholder for number of bytes written
        push charsWrite               ; verifying
        push intmsgLen                        ; Length of the message
        push intmsg              ; Pointer to the message
        push dword [stdHandle]        ; Standard output handle
        call _WriteConsoleA@20


    ; Get the standard input handle
        push -10                     ; STD_INPUT_HANDLE constant is -10
        call _GetStdHandle@4
        mov [stdReadHandle], eax          ; Save the handle

    ; Write the message to standard input
        push 0                                 ; Reserved
        push charsRead                         ; verifying
        push 128                               ; Length of the message
        push inputBuffer                       ; Pointer to the message
        push dword [stdReadHandle]             ; Standard input handle
        call _ReadConsoleA@20

    ;currently, we have an input in inputBuffer, but it is a string
    ;we need to convert it to a number/integer
        movzx eax, byte [inputBuffer]  ; Move input character into eax
        sub eax, '0'                   ; Convert ASCII to integer
    ;comparing for jump
        cmp eax, 1          
    ;jump to if branch if eax == 1
        je add_branch
        cmp eax, 2
        je sub_branch
        cmp eax, 3
        je end_branch
    ;unconditional jump to else branch
        jmp else_branch

add_branch:
    ; Get the standard output handle
    push -11                      ; STD_OUTPUT_HANDLE constant is -11
    call _GetStdHandle@4
    mov [stdHandle1], eax          ; Save the handle
    ;print input prompt for 1st number:
    push 0 
    push charsWrite1    
    push addmsg1Len 
    push addmsg1        ;please enter first number:
    push dword [stdHandle1]
    call _WriteConsoleA@20    

    ;input for 1st operand
    push -10                     ; STD_INPUT_HANDLE constant is -10
    call _GetStdHandle@4
    mov [stdReadHandle], eax          ; Save the handle

    ; Write the message to standard input
    push 0                                 ; Reserved
    push charsRead1                         ; verifying
    push 128                               ; Length of the message
    push input1                      ; Pointer to the message
    push dword [stdReadHandle]             ; Standard input handle
    call _ReadConsoleA@20       ;read system call
    
    ;print operand 2 prompt
    push -11
    call _GetStdHandle@4
    mov [stdHandle1], eax
    
    push 0
    push charsWrite1
    push addmsg2Len
    push addmsg2            ;please enter second number:
    push dword [stdHandle1]
    call _WriteConsoleA@20

    ;input for 2nd operand
    push -10
    call _GetStdHandle@4
    mov [stdReadHandle], eax
    push 0
    push charsRead1
    push 128
    push input2                 ;second operand
    push dword [stdReadHandle]
    call _ReadConsoleA@20       ;read system call

    ;print notice of operation happening
    push -11 
    call _GetStdHandle@4
    mov [stdHandle1], eax
    push charsWrite1
    push addmsg3Len
    push addmsg3
    push dword [stdHandle1]
    call _WriteConsoleA@20

;perform calculation
    mov eax, [input1]       ;moves input1 to eax
    sub eax, '0'            ;converts eax value to digit
    add eax,  [input2]      ; adds input2 to eax
    
jmp calculate_branch        ;jumps to loop that prints value in eax









sub_branch:
  ; Get the standard output handle
    push -11                      ; STD_OUTPUT_HANDLE constant is -11
    call _GetStdHandle@4
    mov [stdHandle1], eax          ; Save the handle
    ;print input prompt for 1st number:
    push 0 
    push charsWrite1    
    push submsg1Len 
    push submsg1        ;please enter first number:
    push dword [stdHandle1]
    call _WriteConsoleA@20    

    ;input for 1st operand
    push -10                     ; STD_INPUT_HANDLE constant is -10
    call _GetStdHandle@4
    mov [stdReadHandle], eax          ; Save the handle

    ; Write the message to standard input
    push 0                                 ; Reserved
    push charsRead1                         ; verifying
    push 128                               ; Length of the message
    push input1                      ; Pointer to the message
    push dword [stdReadHandle]             ; Standard input handle
    call _ReadConsoleA@20           ;read system call
    
    ;print operand 2 prompt
    push -11
    call _GetStdHandle@4
    mov [stdHandle1], eax
    
    push 0
    push charsWrite1
    push submsg2Len
    push submsg2            ;please enter second digit:
    push dword [stdHandle1]
    call _WriteConsoleA@20

    ;input for 2nd operand
    push -10
    call _GetStdHandle@4
    mov [stdReadHandle], eax
    push 0
    push charsRead1
    push 128
    push input2            ;second digit
    push dword [stdReadHandle]
    call _ReadConsoleA@20      ;system call to read

    ;print notice of operation happening
    push -11 
    call _GetStdHandle@4
    mov [stdHandle1], eax
    push charsWrite1
    push submsg3Len
    push submsg3
    push dword [stdHandle1]
    call _WriteConsoleA@20
    ;move 1st number to eax, convert to number
    ;movzx eax, byte [input1]
    ;sub eax, '0'
;perform calculation
    mov eax, [input1]      ;moves input 1 to eax
    add eax, '0'            ;converts value in eax to digit
    sub eax,  [input2]      ;subtracts input2 from eax
    
    jmp calculate_branch       ;jumps to calculate loop to print value in eax

calculate_branch:
    mov [resultChar], eax   ;store value in eax to result char

    push -11
    call _GetStdHandle@4
    mov [stdHandle], eax

    push 0
    push charsWrite
    push 1          ;resultchar length is 1 byte
    push resultChar ;pushes value in resultChar
    push dword [stdHandle]
    call _WriteConsoleA@20  ;writes value
    ;code to print new line
    push 0
    push charsWrite
    push newlineLen
    push newline
    push dword [stdHandle]
    call _WriteConsoleA@20

jmp _start  ;jumps to _start loop and begins again
   

else_branch:
;repeats to _start because improper number has been entered
 ; Get the standard output handle
    push -11                      ; STD_OUTPUT_HANDLE constant is -11
    call _GetStdHandle@4
    mov [stdHandle], eax          ; Save the handle
    ; Write the message to standard output
    push 0                        ; Placeholder for number of bytes written
    push charsWrite4               ; verifying
    push badmsgLen                        ; Length of the message
    push badmsg               ; Pointer to the message
    push dword [stdHandle]        ; Standard output handle
    call _WriteConsoleA@20
jmp _start  ;jumps to _start loop and begins again
    ; Exit the process
    
    ;loop to exit the program
end_branch:
;print goodbye message
push -11
call _GetStdHandle@4
mov [stdHandle], eax

push 0
push charsWrite3
push endmsg1Len
push endmsg1    ;goodbye message
push dword [stdHandle]
call _WriteConsoleA@20
    push 0                        ; Exit code
    call _ExitProcess@4     ;system call to exit
