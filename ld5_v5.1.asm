.model tiny
.code
    org 100h
start:        
; Sukurti programele, kuri paspaudus
; kairiji peles klavisa
; prie zymeklio pamikrsi jusu vardo raide
; jei buvo ivestas 
; 1 - mirkses kas 100 ms
; 2 - mirkses kas 200 ms
; 3 - mirkses kas 300 ms
; jei paspausime desiniji peles klavisa
; tai programa pades 3 taskus
    ; Sukurti programÄ… kuri paspaudus 
    ; kairijÄ¯ pelÄ—s klaviÅ¡Ä… prie Å¾ymeklio pamirksi 
    ; JÅ«sÅ³ vardo raidÄ™: 
    ; jei buvo ivestas 1 - mirksÄ—s kas 100 ms, 
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
    ;mov  ah, 9      ;?¦¦ DISPLAY "RIGHT BUTTON PRESSED"  
    
    mov ah, 0Ah       
    mov al, ' '
    mov cx, 1      
    int 10h 
    
    mov dh, byte ptr cursor_y
    mov dl, byte ptr cursor_x
    mov bh, 0
    mov ah, 2
    int 10h  
    
    mov ah, 0Ah       
    mov al, 'A'
    mov cx, 1      
    int 10h 
    
    
          
tikrinti_desini: 
    ;mov ax, 3
    ;int 33h
    ;CHECK RIGHT BUTTON STATE.
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000010b ;?¦¦ BIT 1 : RIGHT BUTTON.
    jz   mirkseti  ;?¦¦ IF BIT 1 == 0 : NO RIGHT BUTTON.
    
    mov ah, 7
    int 21h 
    
    push cursor_x
    push cursor_y   
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
    
    pop cursor_y
    pop cursor_x 
    
    mov dh, byte ptr cursor_y
    mov dl, byte ptr cursor_x
    mov bh, 0
    mov ah, 2
    int 10h  
    

   
    
   

mirkseti: 
     mov	ah, 2Ch					;Laikas
	int	21h
	cmp	mirksejimo_laikas, dl					;patikrina ar praejo simtoji sekundes dalis
	je	mirkseti					;Jei ne, bus kartojama kol praeis
	mov	mirksejimo_laikas, dl					;Saugome einamosios sekund?s dh registre parodymus
	push	bx					;? stek?

	mov ah, 08h
	mov bh, 0
    int 10h
    
    cmp al, ' '  ; ziurima ar yra simbolis 
    je nera_simbolio
yra_simbolis: ; jei yra simbolis, ji nutrinti
    mov ah, 0Ah
    mov al, ' '
    mov cx, 1
    int 10h    
    jmp short toliau
nera_simbolio: ; jeigu nera simbolio, reikia ji parasyti
    mov ah, 0Ah
    mov al, 'A'
    mov cx, 1
    int 10h 

	jmp	short toliau

toliau:	
    pop	bx
     
    add bx, pasirinktas_greitis 
    mov mirksejimo_laikas, bl





    jmp tikrinti_kairi                                            
cursorpos proc
    ;mov ax, 3

    
    mov cursor_x, cx
    mov cursor_y, dx
    
    mov ax,cursor_x ; bus dalijamas ax
		mov dx,0 ; paruosiame vieta liekanai
		mov cx,8 ; bus dalinama is 8
		div cx   ; dalina ax is cx
		; rezultatas bus irasomas i ax
		; likutis rasomas i dx   
		
	mov cursor_x, ax  ; irasoma zymeklio pozicija  
	
	mov ax,cursor_y 
	mov dx,0 
	mov cx,8 
	div cx    
	
	mov cursor_y, ax 
    
    ret
cursorpos endp

viskas:
    ret

    pradzia_sakinys db 'Iveskite kas kiek laiko mirkses A raide',0Ah,0Dh,'$'
    mirkseti_1 db '[ A ] 100 ms',0Ah,0Dh,'$'
    mirkseti_2 db '[ B ] 200 ms',0Ah,0Dh,'$'
    mirkseti_3 db '[ C ] 300 ms',0Ah,0Dh,'$'
    
    mirksejimo_laikas db ?
   
    cursor_x dw ?
    cursor_y dw ?
    
    pasirinktas_greitis dw ?

end start
