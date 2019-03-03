\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ROUT2"

\\ B%=P%
\\ [OPT pass

.collision
 LDAmyst:BPLcollis2
 RTS
 
.collis2
 LDXaliensm1
.coll1
 STXtemp4
 LDAalst,X:BMIcoll2
.coll3
 LDXtemp4
 DEX:BPLcoll1
 JMPaliensbombs
 
\ Check if an alien has hit me
 
.coll2
 LSRA:BCScoll3
 LDAaly,X
 CMPmyy
 BCCcoll4
 SBCmyy
 CMP#alheight:BCScheck_bomb
 BCCcoll_xcoord
.coll4
 LDAmyy:ADC#1:SEC
 SBCaly,X
 CMP#myheight:BCScheck_bomb
 
.coll_xcoord
 LDAalx,X
 CMPmyx
 BCCcoll5
 SBCmyx
 CMP#mywidth:BCScheck_bomb
 BCCcrash
.coll5
 LDAmyx
 SBCalx,X
 CMP#alwidth:BCScheck_bomb
 
.crash
 SEC:RORmyst
 LDY#maxaliens-1
.iym_dead1
 LDAalst,Y:ORA#1:STAalst,Y
 DEY:BPLiym_dead1
 INCaliens:INCaliensm1
 LDYaliensm1
 LDA#&81:STAalst,Y
 LDAmyy:STAaly,Y
 LDAmyx:STAalx,Y
 LDA#36:STAalgra,Y
 JMPexpsnd
 
\ Now check if an alien has hit one of my bullets
 
.check_bomb
 LDAalst,X
 LSRA:BCScoll3
 LDY#mymaxbull-1
.chkalbull
 STYtemp4+1
 LDXtemp4
 LDAmybullst,Y:BMIcab1
.cab2
 LDYtemp4+1
 DEY:BPLchkalbull
 JMPcoll3
 
.cab1
 LDAaly,X
 CMPmybully,Y:BCCcab2
 SBCmybully,Y
 CMP#alheight:BCScab2:\ +bullheight
 
.cab4
 LDAalx,X
 CMPmybullx,Y:BCCcab5
 SBCmybullx,Y:BNEcab2
 BEQcrash2
.cab5
 LDAmybullx,Y
 SEC:SBCalx,X
 CMP#alwidth:BCScab2
 
.crash2
 LDA#0:STAmybullst,Y
 DECalcount,X:PHP:BNEnot_dead
 LDAalst,X:ORA#1:STAalst,X
.not_dead
 LDYtemp4+1
 LDXmybullx,Y
 LDAmybully,Y:TAY
 JSRmove_bomb
 DECmybullact
 PLP:BNEnot_dead2
 LDXtemp4:JSRadd_to_score
 JSRexpsnd
.not_dead2
 JMPcab2
 
\ Now check if the alien's bombs have hit my ship
 
.aliensbombs
 LDY#almaxbull-1
.albom1
 STYtemp4+1
 LDAalbullst,Y:BMIalbom3
.albom2
 LDYtemp4+1
 DEY:BPLalbom1
 
\ These lines are the protection
\ part of the code!!!
 
 \ LDA &FE66
 \ EOR #&DD BEQ keok
 \ JMP crash
 \ keok
 RTS:\ This is always required!!
 
.albom3
 LDAmyy
 CMPalbully,Y:BCCalbom2
 SBCalbully,Y
 CMP#myheight:BCSalbom2:\ +bullheight
 
 LDAmyx
 CMPalbullx,Y:BCCalbom4
 SBCalbullx,Y:BNEalbom2
 BEQcrash3
.albom4
 LDAalbullx,Y
 SEC:SBCmyx
 CMP#mywidth:BCSalbom2
 
.crash3
 LDA#0:STAalbullst,Y
 LDXalbullx,Y
 LDAalbully,Y:TAY
 JSRdisp_bomb
 DECalbullact
 JMPcrash
 
.alien_hits
 EQUB1:EQUB1:EQUB1:EQUB1:EQUB1
 EQUB10:EQUB2:EQUB5:EQUB5
 EQUB2:EQUB2
 EQUB2
 
 
.expsnd
 LDX#exps1 MOD 256
 LDY#exps1 DIV 256
 JSRmksound
 LDX#exps2 MOD 256
 LDY#exps2 DIV 256
 JMPmksound
 
\ SOUND data for explosion!
 
.exps1
 EQUW &10
 EQUW -15
 EQUW 7
 EQUW 4
 
.exps2
 EQUW &11
 EQUW 1
 EQUW 150:\ 200
 EQUW 4
 
\\ ]
\\ PRINT"Routine 2  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
