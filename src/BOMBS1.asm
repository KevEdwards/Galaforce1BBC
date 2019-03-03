\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"BOMBS1"
\\ B%=P%
\\ [OPT pass
 
.process_my_bombs
 LDAbombdel:BEQprocmybmb
 DECbombdel
.procmybmb
 LDAmybullact:BEQbomb10
 LDX#mymaxbull-1
.bomb6
 STXtemp2
 LDAmybullst,X:BMIbomb7
.bomb9
 LDXtemp2
 DEX:BPLbomb6
 BMIbomb5
 
.bomb7
 LDYmybully,X
 LDAmybullx,X:TAX
 JSRmove_bomb
 LDXtemp2
 LDAmybully,X
 SEC:SBC#8:STAmybully,X
 BNEbomb8
 DECmybullact
 LDA#0:STAmybullst,X
 BEQbomb9
.bomb8
 TAY
 LDAmybullx,X:TAX
 JSRmove_bomb
 JMPbomb9
 
.bomb5
 LDAmybullact
.bomb10
 CMP#mymaxbull:BEQbomb1
 LDAmyst:BMIbomb1
 LDAdemo_flag:BMIbomb11
 BITkey_joy_flag
 BMIkbd_fire
 LDA#&80:LDX#0
 JSRosbyte
 TXA:LSRA:BCCnot_button
 BCSbomb11
.kbd_fire
 LDX#&B6:JSRcheck_key
 BEQbomb11
.not_button
 LDA#0:STAbombdel
 BEQbomb1
.bomb11
 LDAbombdel:BNEbomb1
 LDX#mymaxbull-1
.bomb2
 LDAmybullst,X:BPLbomb3
 DEX:BPLbomb2
 
.bomb1
 RTS
 
.bomb3
 LDA#&FF:STAmybullst,X
 LDA#7:STAbombdel:\  WAS 3!
 STXtemp2
 INCmybullact
 LDAmyx:CLC:ADC#2
 STAmybullx,X:STAtemp1
 LDAmyy:SEC:SBC#23:AND#&F8
 STAmybully,X
 TAY:LDXtemp1
 JSRmove_bomb
 LDX#firesnd MOD 256
 LDY#firesnd DIV 256
 JMPmksound
 
.move_bomb
 JSRxycalc2
 STAscreen+1:STXscreen
 LDY#7
.bomb4
 LDAbombgra,Y
 EOR(screen),Y
 STA(screen),Y
 DEY:BPLbomb4
 LDA#34:LDY#&E
 EOR(screen),Y:STA(screen),Y
.mks2
 RTS
 
.bombgra
 EQUB21:EQUB21:EQUB21:EQUB21:EQUB21:EQUB21
 EQUB51:EQUB1
 
.firesnd
 EQUW &12
 EQUW 2
 EQUW 115
 EQUW 4
 
.mksound
 BITsound_flag:BPLmks2
 BITdemo_flag:BMImks2
 LDA#7:JMPosword
 
\\ ]
\\ PRINT"Bombs 1    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
