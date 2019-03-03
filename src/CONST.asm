\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"CONST"

maxaliens	= 40
maxpatt		= 4
myheight	= 16

alheight	= 16
bullheight	= 8

mywidth		= 6
alwidth		= 6

process		= 6

mymaxbull	= 3
almaxbull	= 6

xstep		= 1
ystep		= 4

graph		= &297A
 
osasci		= &FFE3
osbyte		= &FFF4
oswrch		= &FFEE
osword		= &FFF1
 
\\ PAGE=&5800
\\ RETURN
