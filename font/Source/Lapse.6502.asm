	; Lapse font from https://damieng.com/zx-origins
	.byte 0,0,0,0,0,0,0,0 ;  
	.byte 16,16,16,16,0,16,16,0 ; !
	.byte 108,72,0,0,0,0,0,0 ; "
	.byte 0,18,127,36,36,254,72,0 ; #
	.byte 8,62,72,56,28,18,124,16 ; $
	.byte 98,148,144,108,18,82,140,0 ; %
	.byte 56,64,32,82,140,132,114,0 ; &
	.byte 24,16,0,0,0,0,0,0 ; '
	.byte 24,32,32,32,32,32,24,0 ; (
	.byte 48,8,8,8,8,8,48,0 ; )
	.byte 0,36,24,126,24,36,0,0 ; *
	.byte 0,16,16,124,16,16,0,0 ; +
	.byte 0,0,0,0,0,0,24,16 ; ,
	.byte 0,0,0,126,0,0,0,0 ; -
	.byte 0,0,0,0,0,0,24,0 ; .
	.byte 2,4,8,16,32,64,128,0 ; /
	.byte 56,68,130,130,130,68,56,0 ; 0
	.byte 112,16,16,16,16,16,124,0 ; 1
	.byte 252,2,2,28,96,128,254,0 ; 2
	.byte 254,4,8,60,2,2,252,0 ; 3
	.byte 12,20,36,68,132,126,4,0 ; 4
	.byte 254,128,128,252,2,2,252,0 ; 5
	.byte 126,128,128,252,130,130,124,0 ; 6
	.byte 254,2,4,8,16,32,64,0 ; 7
	.byte 124,130,130,124,130,130,124,0 ; 8
	.byte 124,130,130,126,2,2,252,0 ; 9
	.byte 0,0,24,0,0,0,24,0 ; :
	.byte 0,0,24,0,0,0,24,16 ; ;
	.byte 0,8,16,32,16,8,0,0 ; <
	.byte 0,0,126,0,126,0,0,0 ; =
	.byte 0,32,16,8,16,32,0,0 ; >
	.byte 124,2,2,2,28,0,24,0 ; ?
	.byte 248,4,122,138,138,138,126,0 ; @
	.byte 16,40,40,68,124,130,130,0 ; A
	.byte 252,130,130,252,130,130,252,0 ; B
	.byte 62,64,128,128,128,64,62,0 ; C
	.byte 248,132,130,130,130,132,248,0 ; D
	.byte 254,128,128,254,128,128,254,0 ; E
	.byte 254,128,128,254,128,128,128,0 ; F
	.byte 62,64,128,142,130,66,60,0 ; G
	.byte 130,130,130,254,130,130,130,0 ; H
	.byte 16,16,16,16,16,16,16,0 ; I
	.byte 2,2,2,2,2,2,124,0 ; J
	.byte 130,132,136,240,136,132,130,0 ; K
	.byte 128,128,128,128,128,128,254,0 ; L
	.byte 68,170,170,170,146,146,146,0 ; M
	.byte 66,162,162,146,138,138,132,0 ; N
	.byte 56,68,130,130,130,68,56,0 ; O
	.byte 252,130,130,252,128,128,128,0 ; P
	.byte 56,68,130,130,146,84,56,8 ; Q
	.byte 252,130,130,188,160,152,134,0 ; R
	.byte 126,128,96,16,12,2,252,0 ; S
	.byte 254,16,16,16,16,16,16,0 ; T
	.byte 130,130,130,130,130,130,124,0 ; U
	.byte 130,130,68,68,40,40,16,0 ; V
	.byte 146,146,146,170,170,170,68,0 ; W
	.byte 130,68,40,16,40,68,130,0 ; X
	.byte 130,68,40,16,16,16,16,0 ; Y
	.byte 252,2,12,16,96,128,126,0 ; Z
	.byte 56,32,32,32,32,32,32,56 ; [
	.byte 128,64,32,16,8,4,2,0 ; \
	.byte 56,8,8,8,8,8,8,56 ; ]
	.byte 0,16,40,68,0,0,0,0 ; ^
	.byte 0,0,0,0,0,0,0,255 ; _
	.byte 62,64,64,254,64,64,254,0 ; £
	.byte 0,124,6,26,34,66,62,0 ; a
	.byte 64,124,66,66,66,66,124,0 ; b
	.byte 0,62,64,64,64,64,62,0 ; c
	.byte 2,62,66,66,66,66,62,0 ; d
	.byte 0,60,66,126,64,64,62,0 ; e
	.byte 28,32,120,32,32,32,32,0 ; f
	.byte 0,62,66,66,66,62,2,124 ; g
	.byte 64,124,66,66,66,66,66,0 ; h
	.byte 16,0,16,16,16,16,16,0 ; i
	.byte 8,0,8,8,8,8,8,48 ; j
	.byte 64,66,68,120,72,68,66,0 ; k
	.byte 16,16,16,16,16,16,16,0 ; l
	.byte 0,252,146,146,146,146,146,0 ; m
	.byte 0,124,66,66,66,66,66,0 ; n
	.byte 0,60,66,66,66,66,60,0 ; o
	.byte 0,124,66,66,66,66,124,64 ; p
	.byte 0,62,66,66,66,66,62,2 ; q
	.byte 0,62,64,64,64,64,64,0 ; r
	.byte 0,62,64,48,12,2,124,0 ; s
	.byte 32,124,32,32,32,32,28,0 ; t
	.byte 0,66,66,66,66,66,62,0 ; u
	.byte 0,130,68,68,40,40,16,0 ; v
	.byte 0,146,146,146,170,170,68,0 ; w
	.byte 0,66,36,24,24,36,66,0 ; x
	.byte 0,130,68,68,40,40,16,224 ; y
	.byte 0,124,2,12,48,64,62,0 ; z
	.byte 14,16,16,96,16,16,14,0 ; {
	.byte 16,16,16,16,16,16,16,0 ; |
	.byte 112,8,8,6,8,8,112,0 ; }
	.byte 0,0,36,84,72,0,0,0 ; ~
	.byte 126,129,157,161,161,157,129,126 ; ©