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
   
viskas:

    ret
    
    
    
end start     