	.model	tiny
	.code
	org 100h
	.186					;komandai shr cx, 3
start:
	mov	ax, 13h				;
	int	10h					;grafinis videoreþimas
	mov	ax, 0				;inicializuojame pelæ
	int	33h
	mov	ax, 1				;rodyk pelës þymeklá
	int	33h
	mov	ax, 000Ch			;ájungiame pelës ávykiø apdorojimo programà…
	mov	cx, 0002h			;ávykis - kairiojo pelës klaviðo paspaudimas
	mov	dx, offset buf		;ES:DX - ávykiø apdorojimo buferio adresas
	int	33h
taskai:	mov	ah, 08h
	int	21h					;Laukiame klaviðo t paspaudimo
	cmp	al, "t"
	jne	taskai
	mov	ax, 000Ch			;Iðkvieèiame pelës ávykliø apdorojimo programà…
	mov	cx, 000h
	int	33h					;Atsisakome ávykiø apdorojimo pelei
	mov	ax, 3				;Tekstinis reþimas
	int	10h
	ret

buf:						;Pelës ávykiø apdorojimo programos pradþia
	pusha					;Saugojame visus registrus
	mov	bx, 0
	sar	cx, 1				;Stulpelio koordinatë dalinama ið 2
	inc	cx
	dec	dx
	mov	al, 00000100b
	mov	ah, 0Ch
	int	10h
	popa
	retf
	end	start