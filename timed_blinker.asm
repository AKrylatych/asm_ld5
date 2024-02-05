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
    mov offset pasirinktas_greitis, 500
    jmp pradzia 
    
pradzia:   
       
     ;;  
     mov	ah, 2Ch					;Laikas
	int	21h
	cmp	bl, dl					;Patikriname ar pra�jo sekund�
	je	pradzia					;Jei ne kartok
	mov	bl, dl					;Saugome einamosios sekund�s dh registre parodymus
	push	bx					;� stek�

	mov ah, 08h
	mov bh, 0
    int 10h
    
    cmp al, ' '   
    je nera_simbolio
yra_simbolis:
    mov ah, 0Ah
    mov al, ' '
    mov cx, 1
    int 10h    
    jmp short toliau
nera_simbolio:
    mov ah, 0Ah
    mov al, 'E'
    mov cx, 1
    int 10h 
     
     
     

	jmp	short toliau

toliau:	
    pop	bx 
    add bx, pasirinktas_greitis
	jmp	short pradzia
     ;;  
       
       
  
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
    
    ar_matomas db ?

end start
