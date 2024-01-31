.model tiny
.code
    org 100h
start:
    ; Sukurti programą kuri paspaudus 
    ; kairijį pelės klavišą prie žymeklio pamirksi 
    ; Jūsų vardo raidę: 
    ; jei buvo įvestas 1 - mirksės kas 100 ms, 
    ; 2 - mirksės kas 200 ms, 
    ; 3 - mirksės kas 300 ms. 
    ; Jei paspausime dešinį pelės klavišą, 
    ; tai programa padės 3 taškus.

    mov ah, 09h
    mov dx, offset pradzia
    int 21h
    mov dx, offset mirkseti_1
    int 21h
    mov dx, offset mirkseti_2
    int 21h
    mov dx, offset mirkseti_3
    int 21h


    mov	ax, 13h				;
	int	10h					;grafinis video rezimas
    
	mov	ax, 0				;inicializuojame pele
	int	33h
    mov ax, 0001h
    int 33h


    jmp viskas



; Procedura paraso tris taskus paspaudimo koordinateje
trystaskai proc

trystaskai endp

viskas:
    ret

    pradzia db 'Iveskite kas kiek laiko mirksės A raide',0Ah,0Dh,'$'
    mirkseti_1 db '[ A ] 100 ms',0Ah,0Dh,'$'
    mirkseti_2 db '[ B ] 200 ms',0Ah,0Dh,'$'
    mirkseti_3 db '[ C ] 300 ms',0Ah,0Dh,'$'

end start
