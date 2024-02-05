	.model	tiny
	.code
	org 100h
start:
	mov	ah, 2Ch					;Laikas
	int	21h
	cmp	bl, dl					;Patikriname ar praėjo sekundė
	je	start					;Jei ne kartok
	mov	bl, dl					;Saugome einamosios sekundės dh registre parodymus
	push	bx					;į steką
	mov	ah, 09h			
	mov	dx, offset laikas		;Tekstas ekrane
	int	21h
	cmp	byte ptr offset laikas+2, "9"	;Tikriname ar sekundės neviršijo 9
	jne	maz1					;Jei ne tęsti
	mov	byte ptr offset laikas+2, "0"	;Priešingu atveju įrašome 0
	cmp	byte ptr offset laikas+1, "9"	;Tikriname ar sekundžių dešimtys neviršijo 9 dešimčių
	jne	maz2					;Jei ne tęsti
	mov	byte ptr offset laikas+1, "0"	;Priešingai 0
	cmp	byte ptr offset laikas, "9"	;Tikriname ar sekundžių šimtai neviršijo 9 šimtų
	jne	maz3					;Jei ne tęsti
	mov	byte ptr offset laikas, "0"	;Priešingai 0
	mov	dx, offset ispradz
	int	21h
	jmp	short toliau  
	
maz3:	
    add	byte ptr offset laikas, 1	;Didiname sekundžių šimtus 1
	jmp	short toliau  
	
maz2:	
    add	byte ptr offset laikas+1, 1	;Didiname sekundžių dešimtis 1
	jmp	short toliau   
	
maz1:	
    add	byte ptr offset laikas+2, 1	;Didiname sekundžių vienetus 1  

toliau:	
    pop	bx
	jmp	short start
	ret  
	
	
laikas	db	"000 skaiciuoju kas 1/100 sekundes, stabdymui CTRL+C",0Ah,0Dh,"$" ;Pirmi trys baitai dinamiškai keičiami
ispradz db	0Ah,0Dh,0Ah,0Ah,0Ah,0Ah,"PRADEDAME NUO PRADZIU SKAICIUOTI LAIKA",0Ah,0Dh,"$" 

	end	start