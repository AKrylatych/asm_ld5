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
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000001b ;?¦¦ BIT 0 : LEFT BUTTON.
    jz   tikrinti_desini  ;?¦¦ IF BIT 0 == 0 : NO LEFT BUTTON.
    
   
    
    
    
    
    mov raides_x, cx
    mov raides_y, dx  
    
    mov dh, 10
    mov dl, 20
    mov bh, 0
    mov ah, 2
    int 10h
    
     mov ah, 0Ah  ; spausina raide
    mov al, 'a'
    mov bh,0
    mov cx, 1
    int 10h
       
    
;mov ah, 7
;int 21h 

;    mov ah, 03h          
;    int 10h
      ; Set AH to 09H - write character at cursor position
    ;mov ah, 09h
    ; AL contains the character to print
    ;mov al, 'a'
    ; BH is the page number
    ;mov bh, 0
    ; BL is the attribute (color)
    ;mov bl, 0
    ; CX is the number of times to print the character
    ;mov cx, 1
    ; Call BIOS interrupt 10H
    ;int 10h
    
    ;INT 10h / AH = 03h - get cursor position and size.
;input:
;BH = page number.
;return:
;DH = row.
;DL = column.
;CH = cursor start line.
;CL = cursor bottom line. 
    ;mov  ah, 9      ;?¦¦ DISPLAY "LEFT BUTTON PRESSED"
    ;mov  dx, offset paspaudei_kairi
   ; int  21h
tikrinti_desini:
    ;CHECK RIGHT BUTTON STATE.
    mov  ax, bx  ;?¦¦ PRESERVE BX.
    and  ax, 0000000000000010b ;?¦¦ BIT 1 : RIGHT BUTTON.
    jz   mirkseti  ;?¦¦ IF BIT 1 == 0 : NO RIGHT BUTTON.   
    
    
    
    
    
    ;mov  ah, 9      ;?¦¦ DISPLAY "RIGHT BUTTON PRESSED"  
    
    ;mov dh, 10
    ;mov dl, 20
    ;mov bh, 0
    ;mov ah, 2
    ;int 10h  
           
    ;mov al, 'E'
    ;mov cx, 1      
    ;int 10h        
   
    
   

mirkseti:
    mov ax, 3
    int 33h
    
    
    jmp tikrinti_kairi    
    
    
    jmp viskas

                                        s

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
    cursor_x dw ?
    cursor_y dw ?
    
    pasirinktas_greitis dw ?

end start
