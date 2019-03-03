\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ROUT1"
\\ B%=P%
\\ [OPT pass
 
.check_joy
 LDA#&80
 JSRosbyte
 CPY#&C0:\ was &FF then &E0
 RTS
 
.check_joy2
 LDA#&80
 JSRosbyte
 CPY#&40:\ was 1 then &20
 RORA
 EOR#&80
 ROLA
 RTS
 
.pause4
 LDX#200
 
.check_key
 LDA#&81
 LDY#&FF
 JSRosbyte
 CPY#&FF
 RTS
 
.delay
 LDX#3
.delay2
 LDY#0
.delay3
 DEY:BNEdelay3
 DEX:BNEdelay2
.nopause
 RTS
 
.pause
 JSRsound_on_off
 JSRpause4:BNEnopause
 CLC:RORpause_flag
 LDA#15:LDX#0:JSRosbyte
.pause1
 JSRpause4:BEQpause1
 LDY#0:JSRprnstr
.pause2
 JSRpause4:BNEpause2
.pause3
 JSRpause4:BEQpause3
 SEC:RORpause_flag
 LDY#0:JMPprnstr
 
.rstall
 \LDY#process STYaliens  TEST!!
 \DEY STYaliensm1        TEST!!
 LDA#0
 STAmyst
 STAalmove
 \STAwavoff       TEST !!!!
 STAprocst
 STAmybullact
 STAalbullact
 STAbombdel
 STAinitact
 LDY#maxaliens-1
.rst1
 STAalst,Y
 DEY:BPLrst1
 LDX#maxpatt-1
.rst2
 STAinitst,X:DEX:BPLrst2
 LDY#mymaxbull-1
.rst3
 STAmybullst,Y:DEY:BPLrst3
 LDY#almaxbull-1
.rst4
 STAalbullst,Y:DEY:BPLrst4
 LDA#38:STAmyx
 LDA#227:STAmyy
.seed_rnd
 LDA&FE44:ORA#1:STArand1
 LDA&240:ORA#1:STArand1+1
 LDA&FC:ORA#1:STArand1+2
 RTS
 
.xycalc
 TXA
.xycalc4
 CMP#80:BCCxycalc3
 SBC#80:JMPxycalc4
.xycalc3
 TAX
 CPY#23:BCSxycalc2
 LDA#&C0:RTS
.xycalc2
 LDA#0:STAtemp1+1
 TYA:AND#7:STAtemp1
 TYA:LSRA:LSRA:LSRA:TAY
 TXA:ASLA:ROLtemp1+1:ASLA:ROLtemp1+1
 ASLA:ROLtemp1+1
 ORAtemp1:ADCline_start,Y:TAX
 LDAtemp1+1:ADCline_starth,Y
 RTS
 
.pokmypos
 LDXmyx:LDYmyy:JSRxycalc
 STXscreen:STAscreen+1
 LDY#myheight:STYtemp1+1
.sound_exit
 RTS
 
.sound_on_off
 INCcounter_sound
 LDAcounter_sound
 AND#&F:BNEsound_exit
 JSRkey_joy
 LDX#&AE:\ S key
 JSRcheck_key
 BNEsound_exit
 JSRdisplay_sound_status
 LDAsound_letter
 EOR#(28 EOR 26)
 STAsound_letter
 LDAsound_flag:EOR#&80
 STAsound_flag
 LDA#15:LDX#0:JSRosbyte
.display_sound_status
 LDY#16:\ display 'S' or 'Q'
 JMPprnstr
 
.key_joy
 LDX#&B9:\ K key
 JSRcheck_key:BNEsound_exit
 JSRdisplay_key_joy_status
 LDAkey_joy_letter
 EOR#(19 EOR 20)
 STAkey_joy_letter
 LDAkey_joy_flag:EOR#&80
.key_joy2
 STAkey_joy_flag
.display_key_joy_status
 LDY#18:\ display 'K' or 'J'
 JMPprnstr
 
.addrelx
 EQUB0:EQUBxstep:EQUB0:EQUB-xstep
 EQUBxstep:EQUBxstep:EQUB-xstep:EQUB-xstep
 EQUB0:EQUB2*xstep:EQUB0:EQUB-2*xstep
 EQUB2*xstep:EQUB2*xstep:EQUB-2*xstep:EQUB-2*xstep
 EQUB0:EQUB3*xstep:EQUB0:EQUB-3*xstep
 EQUB3*xstep:EQUB3*xstep:EQUB-3*xstep:EQUB-3*xstep
 EQUB0:EQUB4*xstep:EQUB0:EQUB-4*xstep
 EQUB4*xstep:EQUB4*xstep:EQUB-4*xstep:EQUB-4*xstep
 EQUB0:EQUB5*xstep:EQUB0:EQUB-5*xstep
 EQUB5*xstep:EQUB5*xstep:EQUB-5*xstep:EQUB-5*xstep
 EQUB0:EQUB6*xstep:EQUB0:EQUB-6*xstep
 EQUB6*xstep:EQUB6*xstep:EQUB-6*xstep:EQUB-6*xstep
 EQUB2:EQUB2:EQUB-2:EQUB-2
 EQUB2:EQUB2:EQUB-2:EQUB-2
.addrely
 EQUB-ystep:EQUB0:EQUBystep:EQUB0
 EQUB-ystep:EQUBystep:EQUBystep:EQUB-ystep
 EQUB-2*ystep:EQUB0:EQUB2*ystep:EQUB0
 EQUB-2*ystep:EQUB2*ystep:EQUB2*ystep:EQUB-2*ystep
 EQUB-3*ystep:EQUB0:EQUB3*ystep:EQUB0
 EQUB-3*ystep:EQUB3*ystep:EQUB3*ystep:EQUB-3*ystep
 EQUB-4*ystep:EQUB0:EQUB4*ystep:EQUB0
 EQUB-4*ystep:EQUB4*ystep:EQUB4*ystep:EQUB-4*ystep
 EQUB-5*ystep:EQUB0:EQUB5*ystep:EQUB0
 EQUB-5*ystep:EQUB5*ystep:EQUB5*ystep:EQUB-5*ystep
 EQUB-6*ystep:EQUB0:EQUB6*ystep:EQUB0
 EQUB-6*ystep:EQUB6*ystep:EQUB6*ystep:EQUB-6*ystep
 EQUB-16:EQUB4:EQUB16:EQUB-4
 EQUB-4:EQUB16:EQUB4:EQUB-16
 
 
.line_start
EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80:EQUB0:EQUB&80
 
.line_starth
EQUB&30:EQUB&32:EQUB&35:EQUB&37
EQUB&3A:EQUB&3C:EQUB&3F:EQUB&41:EQUB&44:EQUB&46:EQUB&49:EQUB&4B:EQUB&4E:EQUB&50:EQUB&53:EQUB&55:EQUB&58:EQUB&5A:EQUB&5D:EQUB&5F:EQUB&62
EQUB&64:EQUB&67:EQUB&69:EQUB&6C:EQUB&6E:EQUB&71:EQUB&73:EQUB&76:EQUB&78:EQUB&7B:EQUB&7D

\\ ]
\\ PRINT"Routine 1  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
