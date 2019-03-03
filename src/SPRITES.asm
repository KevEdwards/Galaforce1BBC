\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"SPRITES"
\\ B%=P%
\\ [OPT pass

.sprite
STAgra1+1
STAgra2+1
STAgra3+1
STAgra4+1
STAgra5+1
STAgra6+1
STXgra21+1
STXgra22+1
STXgra23+1
STXgra24+1
STXgra25+1
STXgra26+1
LDAtemp1
STAgra1+2
STAgra2+2
STAgra3+2
STAgra4+2
STAgra5+2
STAgra6+2
STYgra21+2
STYgra22+2
STYgra23+2
STYgra24+2
STYgra25+2
STYgra26+2
LDX#0
.display
LDY#0
.gra1
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra21
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDY#8
.gra2
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra22
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDY#&10
.gra3
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra23
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDY#&18
.gra4
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra24
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDY#&20
.gra5
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra25
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDY#&28
.gra6
LDA&FFFF,X
EOR(screen),Y
STA(screen),Y
.gra26
LDA&FFFF,X
EOR(screen2),Y
STA(screen2),Y
INX
LDAscreen
AND#7:BEQnxt_char_row
DECscreen
.check_second
LDAscreen2
AND#7:BEQnxt_char_row2
DECscreen2
DECtemp1+1:BNEdisplay
JMPthe_end
RTS
.nxt_char_row
SEC
LDAscreen
SBC#&79
STAscreen
LDAscreen+1
SBC#2
STAscreen+1
JMPcheck_second
.nxt_char_row2
SEC
LDAscreen2
SBC#&79
STAscreen2
LDAscreen2+1
SBC#2
STAscreen2+1
DECtemp1+1:BEQthe_end
JMPdisplay
.the_end
RTS

\\ ]
\\ PRINT"Sprites    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
