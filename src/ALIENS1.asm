\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ALIENS1"
\\ B%=P%
\\ [OPT pass
 
.init_new_aliens
 LDAmyst:BPLinit_new_al2
 RTS
 
.init_new_al2
 
 LDAinitact:ORAalmove
 ORAalbullact:BNEalien1
 LDYwavoff:BNEinital1
 LDA(wavbase),Y:STAaliens
 STYprocst:\  start alien=0 !!!
 SEC:SBC#1
 STAaliensm1
 INCwavoff:INY
 
.inital1
 INCwavoff
 LDA(wavbase),Y:BPLalien2
 JSRflagson
 INCcurwave
 LDA#0:STAsixteen_flag
 JSRflagson
 BITdemo_flag:BMIinit_snd
 LDY#7
 LDAcurwave:BEQnt_zone16
 AND#&F:BNEnt_zone16
 LDY#35
.nt_zone16
 JSRStartTune
.init_snd
 JSRmessage_loop
 LDAcurwave
 AND#15:TAY:\    wrap around !!! 
 LDX#0:STXwavoff
 LDAvecwavl,Y:STAwavbase
 LDAvecwavh,Y:STAwavbase+1
.alien1
 RTS
 
.alien2
 CMP#45:BNEspecial
 LDX#33:STXaliens
 DEX:STXaliensm1
.special
 TAY
 LDAvecpatl,Y:STAtemp1
 LDAvecpath,Y:STAtemp1+1
 LDY#0
 LDA(temp1),Y:STAtemp2:INY
.alien4
 LDX#0
.alien5
 LDAinitst,X:BPLalien6
 INX:CPX#maxpatt:BNEalien5
 BEQprocess_aliens
.alien6
 LDA(temp1),Y:BPLnormal_process
 AND#&7F:BPLalien2
.normal_process
 INY
 STAinitx,X
 LDA(temp1),Y:INY
 STAinity,X
 LDA(temp1),Y:INY
 STAinitdel,X
 STAinitcount,X
 LDA(temp1),Y:INY
 STAinitnum,X
 LDA(temp1),Y:INY
 STAinitrelx,X
 LDA(temp1),Y:INY
 STAinitrely,X
 LDA(temp1),Y:INY
 STAinitgra,X
 LDA(temp1),Y:INY
 STAinitpnum,X
 LDA#&80:STAinitst,X
 INCinitact
 DECtemp2:BNEalien4
 RTS
 
\\ ]
\\ PRINT"Aliens 1   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
