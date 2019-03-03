\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ROUT4"
\\ B%=P%
\\ [OPT pass
 
.message_loop
 LDY#&FF
 LDA#0:STAtemp4
 SEC:LDXcurwave:INX:TXA
.sub10
 INY
 CMP#10:BCCsave_wave_text
 SBC#10:BCSsub10
.save_wave_text
 STYwave_text:STAwave_text+1
 LDY#6:JSRprnstr
 CLC:JSRcompletion_message
 
.wait_loop
 JSRescape
 LDAmyst:BMIesc_exit
 JSRmove_my_base
 JSRmovestars
 JSRrand
 JSRprocess_my_bombs
 JSRpause
 LDX#20:JSRdelay2
 DECtemp4:BNEwait_loop
.esc_exit
 SEC:JSRcompletion_message
 LDY#6:JMPprnstr
 
.end_message
 \LDY#12 JSRprnstr
 JSRtitle
 LDY#14:JSRprnstr
 LDY#10:JSRprnstr
 LDY#30:JSRprnstr
 LDY#20:JMPprnstr
 
.escape
 LDAdemo_flag:BPLnot_demomode
 JSRchk_spc_fire
 BEQtest_if_already_dead
 RTS
.not_demomode
 LDX#&8F
 JSRcheck_key:BNEno_escape
.test_if_already_dead
 LDAmyst:BMIno_escape
 JSRliveson
 LDA#0:STAlives
 JMPcrash
.no_escape
 RTS
 
.game_over_loop
 BITdemo_flag:BMIno_escape
 LDY#14:JSRStartTune
 LDY#8:JSRprnstr
 \LDA#90 STAcounter
.game_over2
 JSRmovestars
 JSRpause
 LDX#25:JSRdelay2
 JSRMusicTest:BNEgame_over2
 \DECcounter BNEgame_over2
 LDY#8:JMPprnstr
 
.chk_spc_fire
 LDX#&9D:JSRcheck_key
 BEQspc_pressed
 LDX#0:LDA#&80:JSRosbyte
 CLC
 TXA:AND#1:EOR#1
.spc_pressed
 RTS
 
 
.completion_message
 PHP
 LDAcurwave:TAX
 AND#&F:BNEexit_compl
 TXA
 LSRA:LSRA:LSRA
 BEQexit_compl
 BITsixteen_flag:BMIexit_compl
 CLC:ADC#20:TAY
 CPY#28:BCSexit_compl
 PLP:BCCnot_second_call
 LDA#&FF:STAsixteen_flag
.not_second_call
 JMPprnstr
.exit_compl
 PLP:RTS
 
\\ ]
\\ PRINT"Routine 4  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
