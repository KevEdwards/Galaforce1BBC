\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ALIENS3"
\\ B%=P%
\\ [OPT pass

.move_the_aliens
 LDA#process:STAtemp4
 LDXprocst
.move_aliens
 LDAalst,X:BMImove2
 JSRdelay
.move5
 INCprocst:LDXprocst
 CPXaliens:BNEmove3
 JSRprocess_aliens
 JSRpause
 LDX#0:STXprocst
 INCexpldelay
.move3
 DECtemp4:BNEmove_aliens
 RTS
 
.move2
 LSRA:BCCmove7
 JSRexplosion:JMPmove5
.move7
 LDAalmult,X:BNEmove4
 LDAalpatlow,X:STAtemp2
 LDAalpathigh,X:STAtemp2+1
 LDYalpatoff,X
 INCalpatoff,X
 LDA(temp2),Y
 BMIbranch_wont_reach
 JMPmove6
.branch_wont_reach
 AND#&7F:STAalmult,X
 INY:INCalpatoff,X
 LDA(temp2),Y
 LDYalpatreflect,X
 BPLnot_reverse
 CMP#48:BCSflip_acute_angle
 TAY
 AND#&F8:STAtemp1
 TYA:AND#7:TAY
 LDAflip_table,Y
 ORAtemp1
.flip_acute_angle
 EOR#7
.not_reverse
 STAaldirect,X
 
.move4
 LDAalx,X:LDYaly,X:TAX
 JSRxycalc
 STAscreen+1:STXscreen
 LDXprocst:DECalmult,X
 LDYaldirect,X
 CPY#&40:BCCmoving_alien
 JSRdelay
 JMPmove5
 
.moving_alien
 CLC:LDAalx,X
 ADCaddrelx,Y
.check_x_wrap
 CMP#80:BCCx_not_wrapped
 SBC#80:JMPcheck_x_wrap
.x_not_wrapped
 STAalx,X
 CLC:LDAaly,X
 ADCaddrely,Y:STAaly,X
 TAY:LDAalx,X
.dalg
 TAX
 JSRxycalc
 STAscreen2+1:STXscreen2
 LDA#alheight:STAtemp1+1
 LDXprocst
 LDYalgra,X
 LDXgraph,Y
 LDAgraph+1,Y:STAtemp1
 TAY:TXA
 JSRsprite
 JMPmove5
 
.move6
 INY:STYtemp3+1:TAY
 LDAactiontab,Y:STAtemp1
 LDAactiontab+1,Y:STAtemp1+1
 LDYtemp3+1
 JMP(temp1)
 
.explosion
 LDAexpldelay:AND#1:BNEexpl4
 LDAalx,X:LDYaly,X:TAX
 JSRxycalc
 STAscreen+1:STXscreen
 STAscreen2+1:STXscreen2
 LDA#alheight:STAtemp1+1
 LDXprocst
 LDYalgra,X
 LDAgraph+1,Y:STAtemp1
 LDAgraph,Y:STAtemp3
 CPY#12:BCCexpl2
 LDA#0:STAalgra,X:TAY
 BEQexpl3
.expl2
 INY:INY
 TYA:STAalgra,X
 CPY#12:BCCexpl3
 LDA#&C0:STAscreen2+1
 LDA#0:STAalst,X
 DECalmove
.expl3
 LDXgraph,Y
 LDAgraph+1,Y:TAY
 LDAtemp3
 JMPsprite
.expl4
 RTS
 
 
\ Flip table for reverse patterns
\ Values EORed because of EOR#7
\ which is used after to flip
\ the acute angled 'climbs'.
 
.flip_table
 EQUB 0 EOR 7
 EQUB 3 EOR 7
 EQUB 2 EOR 7
 EQUB 1 EOR 7
 EQUB 7 EOR 7
 EQUB 6 EOR 7
 EQUB 5 EOR 7
 EQUB 4 EOR 7

\\ ]
\\ PRINT"Aliens 3   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
