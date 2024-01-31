	.model	tiny
	.code
	org 100h
	.186					;komandai shr cx, 3
start:
	mov	ax, 13h				
	int	10h					;grafinis video rezimas
	mov	ax, 0				;inicializuojame pele
	int	33h`
	mov	ax, 1				;rodyk peles zymekli
	int	33h
	mov	ax, 000Ch			;ijungiame peles ivykiu apdorojimo programa
	mov	cx, 0002h			;�vykis - kairiojo pel�s klavi�o paspaudimas
	mov	dx, offset buf		;ES:DX - �vyki� apdorojimo buferio adresas
	int	33h
taskai:	mov	ah, 08h
	int	21h					;Laukiame klavi�o t paspaudimo
	cmp	al, "t"
	jne	taskai
	mov	ax, 000Ch			;I�kvie�iame pel�s �vykli� apdorojimo program��
	mov	cx, 000h
	int	33h					;Atsisakome �vyki� apdorojimo pelei
	mov	ax, 3				;Tekstinis re�imas
	int	10h
	ret

buf:						;Pel�s �vyki� apdorojimo programos prad�ia
	pusha					;Saugojame visus registrus
	mov	bx, 0
	sar	cx, 1				;Stulpelio koordinat� dalinama i� 2
	inc	cx
	dec	dx
	mov	al, 00000100b
	mov	ah, 0Ch
	int	10h
	popa
	retf
	end	start