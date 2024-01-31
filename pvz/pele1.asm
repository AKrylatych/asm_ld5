	.model	tiny
	.code
	org 100h
	.186					;komandai shr cx, 3
start:
	mov	ah, 09h				;Laukia kol paspaus 1, 2 arba 3
	mov	dx, offset tekstas
	int	21h	
kas:	mov	ah, 08h
	int	21h					;Laukiame klavišo t paspaudimo
	cmp	al, "1"
	jne	kas1
	mov	cx, 0001h
	jmp	short pirmyn
kas1:	cmp	al, "2"
	jne	kas2
	mov	cx, 000Ah
	jmp	short pirmyn
kas2:	cmp	al, "3"
	jne	kas3
	mov	cx, 0001h
	jmp	short pirmyn
kas3:	mov	ah, 09h			;Laukia kol paspaus t
	mov	dx, offset tekstas1
	int	21h	
	mov	ah, 08h
	int	21h					;Laukiame klavišo t paspaudimo
	cmp	al, "t"
	je	viskas
	jmp	short start
pirmyn:	push	cx
	mov	ax, 13h				;
	int	10h					;grafinis videorežimas
	mov	ax, 0				;inicializuojame pelę
	int	33h
	mov	ax, 1				;rodyk pelės žymeklį
	int	33h
	mov	ax, 000Ch			;įjungiame pelės įvykių apdorojimo programą
	pop	cx					;Pelės klavišų apdorojimo įvykiai
	mov	dx, offset buf		;ES:DX - įvykių apdorojimo buferio adresas
	int	33h
taskai:
	mov	ah, 08h
	int	21h					;Laukiame klavišo t paspaudimo
	cmp	al, "t"
	jne	taskai	
	mov	ax, 000Ch			;Iškviečiame pelės įvyklių apdorojimo programą
	mov	cx, 000h
	int	33h					;Atsisakome įvykių apdorojimo pelei
	mov	ax, 3				;Tekstinis režimas
	int	10h
viskas:	ret

buf:						;Pelės įvykių apdorojimo programos pradžia
	pusha					;Saugojame visus registrus
	mov	bx, 0
	sar	cx, 1				;Stulpelio koordinatė dalinama iš 2
	inc	cx					;Stulpelio koordinatė didinama vienetu
	dec	dx					;Eilutė bus viena aukščiau, nes ištrina pelės žymeklis
	mov	al, 00000100b		;Spalva
	mov	ah, 0Ch				;Funkcijos numeris
	int	10h					;Taškas
	popa					;Gražiname ankstesnes regostrų koordinates
	retf

tekstas:	db "1 - desime taska, kai spustelesite kairiji peles klavisa",0Dh,0Ah
		db "2 - desime taska, kai spustelesite desiniji peles klavisa",0Dh,0Ah
		db "3 - piesime, kai judinsite pele",0Dh,0Ah,"$"
tekstas1:	db 07h,0Ah,0Ah,"Deja, jus paspaudete kita klavisa... ",0Dh,0Ah
		db "Spauskite t - jei tikrai norite baigti, bet kuri kita jei tesite",0Dh,0Ah,"$"
	end	start