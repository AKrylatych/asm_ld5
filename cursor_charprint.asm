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

    
pradzia:   
   
  
  			
    ;mov	ax, 13h		
	;int	10h      
	
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


    
    ;mov ah, 7h
    ;int 21h
    
    
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
    
    
    
 
   
    
   

mirkseti:
    jmp tikrinti_kairi 
    
                                              
cursorpos proc
    
    
    mov cursor_x, cx
    mov cursor_y, dx
    
    mov ax,cursor_x ;preparing the dividend
		mov dx,0 ;zero extension
		mov cx,8 ;preparing the divisor
		div cx   ;divides AX by CX, with quotient being stored in AX, and remainder in DX 
		
	;mov offset raides_x, ax
	;mov offset raides_y, dx
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

    
  
    cursor_x dw ?
    cursor_y dw ?
    
end start
