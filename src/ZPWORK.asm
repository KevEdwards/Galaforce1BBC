\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\REM SAVE"ZPWORK"

\\P%=0:O%=&3000

\\[OPT 6

ORG 0

.colour
.screen		EQUB 0
.savey
			EQUB 0
 
.data
.screen2	EQUB 0
			EQUB 0
.temp
.temp1		EQUB 0
.length
			EQUB 0
 
.width
.temp2		EQUW 0
 
.addres
.temp3		EQUW0
.addres1
.temp4		EQUW 0
.wavbase	EQUW 0
.stardat	SKIP 3 * 31
.rand1		SKIP 3
.whichstar	EQUB 0
.counter	EQUB0
.expldelay	EQUB0
 
.initst		SKIP maxpatt
.initx		SKIP maxpatt
.inity		SKIP maxpatt
.initdel	SKIP maxpatt
.initcount	SKIP maxpatt
.initnum	SKIP maxpatt
.initrelx	SKIP maxpatt
.initrely	SKIP maxpatt
.initgra	SKIP maxpatt
.initpnum	SKIP maxpatt
 
.aliens		EQUB 0
.aliensm1	EQUB 0
 
\\ ]
\\ PRINT'"Zero page from 0 to &";~P%-1
\\ PAGE=&5800
\\RETURN
 
\\ DEFFNres2(gap%)
\\ P%=P%+gap%:O%=O%+gap%
\\ =6
