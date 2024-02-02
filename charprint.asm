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
    
    mov al, 13h
mov ah, 0
int 10h
    
    mov ah, 0Ah
    mov al, 'a'
    mov bh,0
    mov cx, 1
    int 10h   
    
    
    mov dh, 10
mov dl, 20
mov bh, 0
mov ah, 2
int 10h
    
     mov ah, 0Ah
    mov al, 'a'
    mov bh,0
    mov cx, 1
    int 10h   
    
    
    
    jmp viskas





viskas:
    ret

end start
