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
    
	
	mov	ax, 0				;inicializuojame pele
	int	33h
    mov ax, 1
    int 33h

tikrinti_kairi:
    mov ax, 3
    int 33h
    
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000001b ;?¦¦ BIT 0 : LEFT BUTTON.
    jz   tikrinti_desini  ;?¦¦ IF BIT 0 == 0 : NO LEFT BUTTON.   
    call cursorpos
    ;mov  ah, 9      ;?¦¦ DISPLAY "RIGHT BUTTON PRESSED"  
    
    ;mov ah, 0       ; Subfunction 0 of interrupt 10h - Set Video Mode
    ;mov al, 3       ; Video mode 3 represents 80x25 text mode
    ;int 10h         ; Call interrupt 10h to set the video mode
    
    mov dh, byte ptr cursor_y
    mov dl, byte ptr cursor_x
    mov bh, 0
    mov ah, 2
    int 10h 
     
    mov ah, 0Ah        
    mov al, 'E'
    mov cx, 1      
    int 10h 
    
   ;  mov	ax, 13h		
	;int	10h  
          
tikrinti_desini:
    mov ax, 3
    int 33h 
    
    ;CHECK RIGHT BUTTON STATE.
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000010b ;?¦¦ BIT 1 : RIGHT BUTTON.
    jz   mirkseti  ;?¦¦ IF BIT 1 == 0 : NO RIGHT BUTTON.   
    
    call cursorpos
    
    
    mov dh, byte ptr cursor_y
    mov dl, byte ptr cursor_x
    mov bh, 0
    mov ah, 2
    int 10h 
     
    mov ah, 0Ah        
    mov al, '.'
    mov cx, 3      
    int 10h 
    
  

mirkseti: 



    jmp tikrinti_kairi 
    
                                              
cursorpos proc
    
    
    mov cursor_x, cx
    mov cursor_y, dx
    
    mov ax,cursor_x ;preparing the dividend
		mov dx,0 ;zero extension
		mov cx,8 ;preparing the divisor
		div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX 
		

	mov cursor_x, ax    
	
	mov ax,cursor_y ;preparing the dividend
	mov dx,0 ;zero extension
	mov cx,8 ;preparing the divisor
	div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX     
	
	mov cursor_y, ax 
    
    ret
cursorpos endp
viskas:
    ret

    pradzia_sakinys db 'Iveskite kas kiek laiko mirksÄ—s A raide',0Ah,0Dh,'$'
    mirkseti_1 db '[ A ] 100 ms',0Ah,0Dh,'$'
    mirkseti_2 db '[ B ] 200 ms',0Ah,0Dh,'$'
    mirkseti_3 db '[ C ] 300 ms',0Ah,0Dh,'$'
    paspaudei_kairi db 'uraa',0Ah,0Dh,'$'
    
    raides_x dw ?
    raides_y dw ?   
    cursor_x dw ?
    cursor_y dw ?
    
    pasirinktas_greitis dw ?

end start
