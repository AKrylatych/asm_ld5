.model tiny
.code
    org 100h
start:
    ; Sukurti programÄ… kuri paspaudus 
    ; kairijÄ¯ pelÄ—s klaviÅ¡Ä… prie Å¾ymeklio pamirksi 
    ; JÅ«sÅ³ vardo raidÄ™: 
    ; jei buvo Ä¯vestas 1 - mirksÄ—s kas 100 ms, 
    ; 2 - mirksÄ—s kas 200 ms, 
    ; 3 - mirksÄ—s kas 300 ms. 
    ; Jei paspausime deÅ¡inÄ¯ pelÄ—s klaviÅ¡Ä…, 
    ; tai programa padÄ—s 3 taÅ¡kus.

    mov ah, 09h
    mov dx, offset pradzia_sakinys
    int 21h
    mov dx, offset mirkseti_1
    int 21h
    mov dx, offset mirkseti_2
    int 21h
    mov dx, offset mirkseti_3
    int 21h
    
    ;mov ah, 7h
    ;int 21h   
    mov ah, 01h ; Pasirenkame veiksma
    int 21h
    
    cmp al, 41h
    je simtas
    cmp al, 42h
    je dusimtai
    cmp al, 43h
    je tryssimt
    
    
simtas:
    mov offset pasirinktas_greitis, 100
    jmp pradzia  

dusimtai:
    mov offset pasirinktas_greitis, 200
    jmp pradzia 
tryssimt:
    mov offset pasirinktas_greitis, 300
    jmp pradzia 
    
pradzia:   
    
    mov ah, 01h 
    mov	ax, 13h				;
	int	10h					;grafinis video rezimas
    
	mov	ax, 0				;inicializuojame pele
	int	33h
    mov ax, 1
    int 33h

tikrinti_kairi:
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000001b ;?¦¦ BIT 0 : LEFT BUTTON.
    jz   tikrinti_desini  ;?¦¦ IF BIT 0 == 0 : NO LEFT BUTTON.
    
    mov raides_x, cx
    mov raides_y, dx 
    mov  ah, 9      ;?¦¦ DISPLAY "LEFT BUTTON PRESSED"
    mov  dx, offset paspaudei_kairi
    int  21h
tikrinti_desini:
    ;CHECK RIGHT BUTTON STATE.
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000010b ;?¦¦ BIT 1 : RIGHT BUTTON.
    jz   mirkseti  ;?¦¦ IF BIT 1 == 0 : NO RIGHT BUTTON.
    ;mov  ah, 9      ;?¦¦ DISPLAY "RIGHT BUTTON PRESSED"  
    mov ah,0Ch
    mov al,00110011b
    mov bh,0
    sar cx, 1
    ;mov cx,x_coord
    ;mov dx,y_coord
    int 10h
    
    add cx, 5
    int 10h
    add cx,5
    int 10h


    
    
    
    ;lea  dx, right                                     
    
    ;int  21h

mirkseti:
    mov ax, 3
    int 33h
    
   ; mov ah, 02h  ; Get current video mode
;int 10h
;cmp al, 3  ; Check if video mode is text mode (mode 3)
;jne not_text_mode

; Calculate text mode position
mov bh, 0  ; Page number
mov cx, raides_x  ; Mouse X coordinate
mov dx, raides_y  ; Mouse Y coordinate
mov ax, 320  ; Number of pixels per row in graphics mode
div ax  ; Divide by pixels per character
mov ax, cx  ; Save the column in AX
mov bx, 80  ; Number of columns in text mode
div bx  ; Divide by number of columns
add dx, ax  ; Calculate row number
mov ax, 40  ; Number of rows in text mode
mul dx  ; Multiply by number of columns
add ax, bx  ; Calculate the offset in text mode
mov cx, ax  ; Store the offset in CX

mov ah, 0Eh  ; Teletype output
mov al, 'X'  ; Character to be displayed
mov bh, 0    ; Page number
mov bl, 7    ; Text attribute (7 is white on black, you can change it)
int 10h      ; Video interrupt

not_text_mode:

    
    jmp tikrinti_kairi    
    
    
    jmp viskas



; Procedura paraso tris taskus paspaudimo koordinateje
trystaskai proc

trystaskai endp

viskas:
    ret

    pradzia_sakinys db 'Iveskite kas kiek laiko mirksÄ—s A raide',0Ah,0Dh,'$'
    mirkseti_1 db '[ A ] 100 ms',0Ah,0Dh,'$'
    mirkseti_2 db '[ B ] 200 ms',0Ah,0Dh,'$'
    mirkseti_3 db '[ C ] 300 ms',0Ah,0Dh,'$'
    paspaudei_kairi db 'uraa',0Ah,0Dh,'$'
    
    raides_x dw ?
    raides_y dw ?
    
    pasirinktas_greitis dw ?

end start
