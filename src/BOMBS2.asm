\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"BOMBS2"
\\ B%=P%
\\ [OPT pass
 
.process_aliens_bombs
 
\ Try to init a bomb (random)
 
 LDAalbullact
 CMP#almaxbull:BEQnobomb
 LDAaliensm1:CMP#20:BCCprb2
 LDAalgra+32
 CMP#22:BNEprb2
 LDArand1+1:AND#&F:BNEprb2
 LDA#32:BNEprb
.prb2
 JSRrand
.bombrate
 AND#15:BNEnobomb
 LDArand1+1:AND#63
 CMPaliens:BCSnobomb
.prb
 TAX:LDAalst,X:BPLnobomb
 LSRA:BCSnobomb
 JSRinit_bomb
 
\ Process the alien bombs
 
.nobomb
 LDAalbullact:BEQnone_move
 LDX#almaxbull-1
.malbomb
 STXtemp2
 LDAalbullst,X:BMImalbomb2
.malbomb3
 LDXtemp2
 DEX:BPLmalbomb
.none_move
 RTS
 
.malbomb2
 LDAalbullspeed,X
 BMIalways_move
 LDA#1:BITcounter
 BNEmalbomb3
.always_move
 LDYalbully,X
 LDAalbullx,X:TAX:STXtemp2+1
 JSRdisp_bomb
 LDXtemp2
 LDAalbully,X
 CLC:ADC#8
 STAalbully,X
 BCCmalbomb4
 LDA#0:STAalbullst,X
 DECalbullact
 JMPmalbomb3
 
.malbomb4
 TAY
 LDAaliensm1
 CMP#20:BCSmalbomb5
 LDAcurwave
 CMP#13:BCCmalbomb5:\ Homing bombs
 CMP#29:BCShomi1
 LDAalbullspeed,X
 BMImalbomb5
.homi1
 LDArand1+1:BMImalbomb5
 LDAmyx:CLC:ADC#2
 CMPalbullx,X:BEQmalbomb5
 BCSmalbomb6
 DECtemp2+1:DECalbullx,X
 JMPmalbomb5
.malbomb6
 INCtemp2+1:INCalbullx,X
.malbomb5
 LDXtemp2+1
 JSRdisp_bomb
 JMPmalbomb3
 
\ Subroutine to init a bomb
\ if possible!
 
.init_bomb
 LDAcurwave:CMP#3:BCCno_bomb_allowed
 LDY#almaxbull-1
.dropb1
 LDAalbullst,Y:BPLdropb2
 DEY:BPLdropb1
.no_bomb_allowed
 RTS
 
.dropb2
 LDAaly,X
 CMP#24:BCCno_bomb_allowed
 CMP#240:BCSno_bomb_allowed
 ADC#8:AND#&F8
 STAalbully,Y:STAtemp2
 CMP#80:BCCany_speed
 AND#&7F:BCSslow_only
.any_speed
 JSRrand
.slow_only
 STAalbullspeed,Y
 LDA#&FF:STAalbullst,Y
 INCalbullact
 LDAalx,X:CLC:ADC#2
 STAalbullx,Y:TAX
 LDYtemp2
 
\ Subroutine to display/erase
\ a bomb.
 
.disp_bomb
 JSRxycalc2
 STAscreen+1:STXscreen
 LDY#9
.disp_b2
 LDAalbomb,Y
 EOR(screen),Y
 STA(screen),Y
 DEY:BPLdisp_b2
 RTS
 
.albomb
 EQUB8:EQUB12:EQUB20:EQUB20:EQUB20:EQUB20:EQUB20:EQUB20
 EQUB8:EQUB8

\\ ]
\\ PRINT"Bombs 2    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
