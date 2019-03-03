\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"VECTORS"
\\ B%=P%
\\ [OPT pass

.vecwavl
 EQUB wave0 MOD 256
 EQUB wave1 MOD 256
 EQUB wave2 MOD 256
 EQUB wave3 MOD 256
 EQUB wave4 MOD 256
 EQUB wave5 MOD 256
 EQUB wave6 MOD 256
 EQUB wave7 MOD 256
 EQUB wave8 MOD 256
 EQUB wave9 MOD 256
 EQUB wave10 MOD 256
 EQUB wave11 MOD 256
 EQUB wave12 MOD 256
 EQUB wave13 MOD 256
 EQUB wave14 MOD 256
 EQUB wave15 MOD 256
.vecwavh
 EQUB wave0 DIV 256
 EQUB wave1 DIV 256
 EQUB wave2 DIV 256
 EQUB wave3 DIV 256
 EQUB wave4 DIV 256
 EQUB wave5 DIV 256
 EQUB wave6 DIV 256
 EQUB wave7 DIV 256
 EQUB wave8 DIV 256
 EQUB wave9 DIV 256
 EQUB wave10 DIV 256
 EQUB wave11 DIV 256
 EQUB wave12 DIV 256
 EQUB wave13 DIV 256
 EQUB wave14 DIV 256
 EQUB wave15 DIV 256
.vecpatl
 EQUB patt0 MOD 256
 EQUB patt1 MOD 256
 EQUB patt2 MOD 256
 EQUB patt3 MOD 256
 EQUB patt4 MOD 256
 EQUB patt5 MOD 256
 EQUB patt6 MOD 256
 EQUB patt7 MOD 256
 EQUB patt8 MOD 256
 EQUB patt9 MOD 256
 EQUB patt10 MOD 256
 EQUB patt11 MOD 256 
 EQUB patt12 MOD 256
 EQUB patt13 MOD 256
 EQUB patt14 MOD 256
 EQUB patt15 MOD 256
 EQUB patt16 MOD 256
 EQUB patt17 MOD 256
 EQUB patt18 MOD 256
 EQUB patt19 MOD 256
 EQUB patt20 MOD 256
 EQUB patt21 MOD 256
 EQUB patt22 MOD 256
 EQUB patt23 MOD 256
 EQUB patt24 MOD 256
 EQUB patt25 MOD 256
 EQUB patt26 MOD 256
 EQUB patt27 MOD 256
 EQUB patt28 MOD 256
 EQUB patt29 MOD 256
 EQUB patt30 MOD 256
 EQUB patt31 MOD 256
 EQUB patt32 MOD 256
 EQUB patt33 MOD 256
 EQUB patt34 MOD 256
 EQUB patt35 MOD 256
 EQUB patt36 MOD 256
 EQUB patt37 MOD 256
 EQUB patt38 MOD 256
 EQUB patt39 MOD 256
 EQUB patt40 MOD 256
 EQUB patt41 MOD 256
 EQUB patt42 MOD 256 
 EQUB patt43 MOD 256
 EQUB patt44 MOD 256
 EQUB patt45 MOD 256
.vecpath
 EQUB patt0 DIV 256
 EQUB patt1 DIV 256
 EQUB patt2 DIV 256
 EQUB patt3 DIV 256
 EQUB patt4 DIV 256
 EQUB patt5 DIV 256
 EQUB patt6 DIV 256
 EQUB patt7 DIV 256
 EQUB patt8 DIV 256
 EQUB patt9 DIV 256
 EQUB patt10 DIV 256
 EQUB patt11 DIV 256
 EQUB patt12 DIV 256
 EQUB patt13 DIV 256
 EQUB patt14 DIV 256
 EQUB patt15 DIV 256
 EQUB patt16 DIV 256
 EQUB patt17 DIV 256
 EQUB patt18 DIV 256
 EQUB patt19 DIV 256
 EQUB patt20 DIV 256
 EQUB patt21 DIV 256
 EQUB patt22 DIV 256
 EQUB patt23 DIV 256
 EQUB patt24 DIV 256
 EQUB patt25 DIV 256
 EQUB patt26 DIV 256
 EQUB patt27 DIV 256
 EQUB patt28 DIV 256
 EQUB patt29 DIV 256
 EQUB patt30 DIV 256
 EQUB patt31 DIV 256
 EQUB patt32 DIV 256
 EQUB patt33 DIV 256
 EQUB patt34 DIV 256
 EQUB patt35 DIV 256
 EQUB patt36 DIV 256
 EQUB patt37 DIV 256
 EQUB patt38 DIV 256
 EQUB patt39 DIV 256
 EQUB patt40 DIV 256
 EQUB patt41 DIV 256
 EQUB patt42 DIV 256
 EQUB patt43 DIV 256
 EQUB patt44 DIV 256
 EQUB patt45 DIV 256
.vecpatdl
 EQUB patdat0 MOD 256
 EQUB patdat1 MOD 256
 EQUB patdat2 MOD 256
 EQUB patdat3 MOD 256
 EQUB patdat4 MOD 256
 EQUB patdat5 MOD 256
 EQUB patdat6 MOD 256
 EQUB patdat7 MOD 256
 EQUB patdat8 MOD 256 
 EQUB patdat9 MOD 256
 EQUB patdat10 MOD 256
 EQUB patdat11 MOD 256
 EQUB patdat12 MOD 256
 EQUB patdat13 MOD 256
 EQUB patdat14 MOD 256
 EQUB patdat15 MOD 256
 EQUB patdat16 MOD 256
 EQUB patdat17 MOD 256
 EQUB patdat18 MOD 256
 EQUB patdat19 MOD 256
 EQUB patdat20 MOD 256
 EQUB patdat21 MOD 256
 EQUB patdat22 MOD 256
 EQUB patdat23 MOD 256
 EQUB patdat24 MOD 256
 EQUB patdat25 MOD 256
 EQUB patdat26 MOD 256
 EQUB patdat27 MOD 256
 EQUB patdat28 MOD 256
 EQUB patdat29 MOD 256
.vecpatdh
 EQUB patdat0 DIV 256
 EQUB patdat1 DIV 256
 EQUB patdat2 DIV 256
 EQUB patdat3 DIV 256
 EQUB patdat4 DIV 256
 EQUB patdat5 DIV 256
 EQUB patdat6 DIV 256
 EQUB patdat7 DIV 256
 EQUB patdat8 DIV 256
 EQUB patdat9 DIV 256
 EQUB patdat10 DIV 256
 EQUB patdat11 DIV 256
 EQUB patdat12 DIV 256
 EQUB patdat13 DIV 256
 EQUB patdat14 DIV 256
 EQUB patdat15 DIV 256
 EQUB patdat16 DIV 256
 EQUB patdat17 DIV 256
 EQUB patdat18 DIV 256 
 EQUB patdat19 DIV 256
 EQUB patdat20 DIV 256
 EQUB patdat21 DIV 256
 EQUB patdat22 DIV 256
 EQUB patdat23 DIV 256
 EQUB patdat24 DIV 256
 EQUB patdat25 DIV 256
 EQUB patdat26 DIV 256
 EQUB patdat27 DIV 256
 EQUB patdat28 DIV 256
 EQUB patdat29 DIV 256
 
 
\\ ]
\\ PRINT"Vectors    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
