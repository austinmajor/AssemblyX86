; program to display instructions for "Towers of Hanoi" puzzle
; author:  R. Detmer
; revised: 6/2013
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
prompt BYTE   "How many disks?",0
number BYTE   16 DUP (?)
outLbl BYTE   "Move disk", 0
outMsg BYTE   "from spindle "
source BYTE   ?, 0ah, 0dh
       BYTE   'to spindle '
dest   BYTE   ?, 0

.CODE
_MainProc PROC
       mov    al,'C'       ; argument 4: 'C'
       push   eax
       mov    al,'B'       ; argument 3: 'B'
       push   eax
       mov    al,'A'       ; argument 2: 'A'
       push   eax
       input  prompt, number,16   ; read ASCII characters
       atod   number       ; convert to integer
       push   eax          ; argument 1: number
       call   move         ; Move(number,Source,Dest,Spare)
       add    esp,16       ; remove parameters from stack
         
       mov    eax, 0  ; exit with return code 0
       ret
_MainProc ENDP

move   PROC NEAR32
; procedure move(nbrDisks : integer; { number of disks to move }
;                source, dest, spare : character { spindles to use } )
; all parameters are passed in doublewords on the stack

       push   ebp             ; save base pointer
       mov    ebp,esp         ; establish stack frame
       push   eax             ; save registers
       push   ebx

       cmp    DWORD PTR [ebp+8],1  ; nbrDisks = 1?
       jne    elseMore        ; skip if more than 1
       mov    ebx,[ebp+12]    ; source
       mov    source,bl       ; copy character to output
       mov    ebx,[ebp+16]    ; destination
       mov    dest,bl         ; copy character to output
       output outLbl, outMsg  ; display move instruction
       jmp    endIfOne        ; return
elseMore:
       mov    eax,[ebp+8]     ; get nbrDisks
       dec    eax             ; nbrDisks - 1
       push   DWORD PTR [ebp+16] ; par 4: old destination is new spare
       push   DWORD PTR [ebp+20] ; par 3: old spare is new destination
       push   DWORD PTR [ebp+12] ; par 2: source does not change
       push   eax             ; par 1: nbrDisks-1
       call   move            ; move(nbrDisks-1,source,spare,destination)
       add    esp,16          ; remove parameters from stack

       push   DWORD PTR [ebp+20] ; par 4: spare unchanged
       push   DWORD PTR [ebp+16] ; par 3: destination unchanged
       push   DWORD PTR [ebp+12] ; par 2: source does not change
       pushd  1               ; par 1: 1
       call   move            ; move(1,source,destination,spare)
       add    esp,16          ; remove parameters from stack

       push   DWORD PTR [ebp+12] ; par 4: original source is spare
       push   DWORD PTR [ebp+16] ; par 3: original destination
       push   DWORD PTR [ebp+20] ; par 2: source is original spare
       push   eax             ; parameter 1: nbrDisks-1
       call   move            ; move(nbrDisks-1,spare,destination,source)
       add    esp,16          ; remove parameters from stack
endIfOne:
       pop    ebx             ; restore registers
       pop    eax
       pop    ebp             ; restore base pointer
       ret                    ; return
move   ENDP
END

