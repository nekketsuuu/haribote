; haribote-os
; TAB=4

		ORG		0xc200			; このプログラムがどこに読み込まれるのか

		MOV		AL,0x13			; VGAグラフィクス、320x220x8bitカラー
		MOV		AH,0x00
		INT		0x10
fin:
		HLT
		JMP		fin
