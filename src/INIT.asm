\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"INIT"
\\ B%=P%
\\ [OPT pass

.exec
 LDX#&FF:TXS
 JSRStop
 SEI
 LDA#dem_sound MOD 256:STA&220
 LDA#dem_sound DIV 256:STA&221
 CLI
 LDY#&E:LDA#0
.setup_hiscore
 STAmyscore-1,Y
 DEY:BNEsetup_hiscore
 LDA#3:STAhiscore+2
\ LDA#&90 LDX#0 LDY#1 JSRosbyte
 LDA#22:JSRoswrch
 LDA#2:JSRoswrch
 LDA#10:STA&FE00
 LDA#32:STA&FE01
 JSRseed_rnd
 JSRstarinit
 LDY#2:JSRprnstr
 LDY#4:JSRprnstr
 LDA#&80:STAsound_flag
 STApause_flag
 STAkey_joy_flag
 JSRdisplay_sound_status
 JSRdisplay_key_joy_status
 
 JSRinit_score
 JSRwait_for_space
 TAY
 
\   The 'game' loop
 
.restart
 LDA#3:STAlives
 STAsixteen_flag:\ +ve allows it to be printed
 STAextra_life_flag
 STYcurwave
 LDAvecwavl,Y:STAwavbase
 LDAvecwavh,Y:STAwavbase+1
 JSRflagson
 LDA#14:LDX#4:JSRosbyte
 LDAdemo_flag:BMIno_st_tune
 LDY#0:JSRStartTune
.no_st_tune
 LDA#0:STAwavoff
 LDY#process:STYaliens
 DEY:STYaliensm1
 
 JSRinit_score
 JMPfirst_life
 
.next_life
 JSRliveson
 LDY#0:LDA(wavbase),Y
 STAaliens
 SEC:SBC#1:STAaliensm1
 DECwavoff
 DEClives
 BNEfirst_life
 LDX#lstman MOD 256
 LDY#lstman DIV 256
 JSRmksound
.first_life
 JSRliveson
 JSRrstall
 JSRpokmypos
 LDA#&C0:STAscreen2+1
 LDAgraph+36
 TAX
 LDYgraph+37
 STYtemp1
 JSRsprite
 JSRmessage_loop
 
.main_loop
 CLI
 INCcounter
 JSRescape
 JSRrand
 JSRmove_my_base
 JSRmovestars
 JSRinit_new_aliens
 JSRmove_the_aliens
 JSRprocess_my_bombs
 JSRprocess_aliens_bombs
 JSRcollision
 
 LDAmyst:BPLmain_loop
 LDAalmove:BPLmain_loop
 LDAalbullact:ORAmybullact
 BNEmain_loop
 JSRdie_loop
 LDAlives:BNEnext_life
 JSRcheck_new_high
 LDA#&31:STAscreen+1
 JSRpoke_hi_scr
 JSRgame_over_loop
 JSRahigh:\        ??? TEST
 JSRwait_for_space
 PHA
 JSRflagson
 PLA:TAY
 JMPrestart
 
.wait_for_space
 JSRend_message
 LDA#0:STAcounter
 
.space_loop
 JSRsrlp
 INCcounter:BEQhsclp
 JSRchk_spc_fire
 BNEspace_loop
 PHP
 JSRend_message
.jkch
 JSRdisplay_key_joy_status
 PLP
 LDA#0:ADC#19:STAkey_joy_letter
 LDX#&FF
 CMP#20:BEQset_kbd_negative
 INX
.set_kbd_negative
 TXA:JSRkey_joy2
 LDA#0:STAdemo_flag
 RTS
 
.hsclp
 JSRend_message
 JSRpht
.hscl2
 JSRsrlp
 INCcounter:BEQinto_demo
 JSRchk_spc_fire
 BNEhscl2
 PHP
 JSRpht
 JMPjkch
 
.into_demo
 JSRpht
 LDX#&FF:STXdemo_flag
 STXdemo_count
 INX:STXdem_section
 JSRrand:AND#7:\ Random start for demo
 RTS
 
.process_demo
 LDAdemo_flag:BPLnot_in_demo
 DECdemo_count:BPLnot_in_demo
 LDArand1+1:STAdemo_direction
 AND#15:ADC#10:STAdemo_count
.not_in_demo
 RTS
 
\ Event routine for Tune
\ Refreshing
 
.dem_sound
 CMP#4:BNEex_dem2
 BITpause_flag:BPLex_dem2
 TXA:PHA:TYA:PHA
 JSRRefresh
 JSRMusicTest:BNEex_dem
 DECdem_section
 BPLnot_new_tune
 LDA#7:STAdem_section
.not_new_tune
 LDXdem_section:LDYdem_table,X
 LDAdemo_flag:BPLex_dem
 JSRStartTune
 JSRRefresh
.ex_dem
 PLA:TAY:PLA:TAX
.ex_dem2
 RTS
 
\ Backwards order for demo
\ tunes ie 21,21,42,42,..
 
.dem_table
 EQUB56:EQUB56:EQUB49:EQUB49
 EQUB42:EQUB42:EQUB21:EQUB21
 
.die_loop
 BITdemo_flag:BMIdl1
 LDY#28:JSRStartTune
.dl2
 JSRmovestars
 JSRpause
 LDX#22:JSRdelay2
 JSRMusicTest
 BNEdl2
.dl1
 RTS
 
.lstman
 EQUW &13
 EQUW 9
 EQUW 160
 EQUW 50
 
.srlp
 LDX#24:JSRdelay2
 JSRmovestars
 JMPpause
 
\\ ]
\\ PRINT"Init       from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
