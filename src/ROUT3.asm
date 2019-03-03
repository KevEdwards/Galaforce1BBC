\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ROUT3"
\\ B%=P%
\\ [OPT pass
 
.move_my_base
 LDAmyst:BPLok_to_move
 RTS
 
.ok_to_move
 JSRprocess_demo
 LDY#0:STYtemp3+1:STYtemp3
 BITdemo_flag:BPLmanual_control
 INY
 BITdemo_direction:BPLdem_right
 INY
.dem_right
 STYtemp3
 JMPpossible_move
 
.manual_control
 
\ Protection code follows
 
 \ LDA &FE67 CLC ADC #&A2
 \ BEQ keo2
 \ JMP ship_hasnt_moved
 \ keo2
 
 BITkey_joy_flag
 BMIuse_keyboard
 
 LDX#1:JSRcheck_joy
 ROLtemp3
 LDX#1:JSRcheck_joy2
 ROLtemp3
 LDX#2:JSRcheck_joy
 ROLtemp3+1
 LDX#2:JSRcheck_joy2
 ROLtemp3+1
 JMPpossible_move
 
.use_keyboard
 LDX#&9E:JSRcheck_key:\ Z key
 ROLtemp3
 LDX#&BD:JSRcheck_key:\ X key
 ROLtemp3
 LDX#&B7:JSRcheck_key:\ colon key
 ROLtemp3+1
 LDX#&97:JSRcheck_key:\ / key
 ROLtemp3+1
 
.possible_move
 JSRpokmypos
 LDYtemp3
 LDAkey_press_relx,Y
 CLC:ADCmyx
 CMP#75:BCSbad_x_position
 STAmyx
.bad_x_position
 LDYtemp3+1
 LDAkey_press_rely,Y
 CLC:ADCmyy
 CMP#165:BCCbad_y_pos
 CMP#235:BCSbad_y_pos
.good_y_pos
 STAmyy
.bad_y_pos
 LDYmyy:LDXmyx
 JSRxycalc
 STAscreen2+1
 STXscreen2
 EORscreen+1
 BNEship_has_moved
 TXA:EORscreen
 BEQship_hasnt_moved
.ship_has_moved
 LDA#myheight:STAtemp1+1
 LDAgraph+36
 TAX
 LDYgraph+37
 STYtemp1
 JMPsprite
 
.ship_hasnt_moved
 LDAdemo_direction
 EOR#&80
 STAdemo_direction
 JMPdelay
 
.key_press_rely
 EQUB0:EQUB3:EQUB-3:EQUB0
.key_press_relx
 EQUB0:EQUB1:EQUB&FF:EQUB0
 
\------------------------------
 
 
.print_scores
 STXtemp1
.pscore3
 LDYscore_base,X
 LDXmult24tab,Y
 STXpscore1+1
 LDY#23
.pscore1
 LDA&A00,Y:\ Digit graphics
 STA(screen),Y
 DEY:BPLpscore1
 LDXtemp1
 RTS
 
.init_score
 JSRreset_score_to_0
.poke_hi_scr
 LDA#&98:STAscreen
 LDX#7:STXtemp2
.inscr1
 LDAscore_base,X:BNEinscr2
 LDYtemp2:BNEinscr3
.inscr2
 LDA#0:STAtemp2
 JSRprint_scores
.inscr3
 LDAscreen
 CLC:ADC#24:STAscreen
 BCCinscr4
 INCscreen+1
.inscr4
 INX:CPX#14:BNEinscr1
 RTS
 
.add_to_score
 LDA#&20:STAscreen
 LDA#&31:STAscreen+1
 LDAalgra,X:SEC:SBC#12
 LSRA:TAX
 LDAalien_score,X
 LDX#5
.addscr2
 STAtemp1
 LDAscreen:SEC:SBC#24:STAscreen
 BCSaddscr4
 DECscreen+1
.addscr4
 LDAtemp1
 CLC
 ADCmyscore,X
 CMP#10:BCCaddscr3
 SBC#10
 STAmyscore,X
 JSRprint_scores
 LDA#1
 DEX:BPLaddscr2
 JMPreset_score_to_0
.addscr3
 STAmyscore,X
 CPX#2:BNEnot_ten_thousands
 BITextra_life_flag
 BMInot_ten_thousands
 CMP#2:BNEnot_ten_thousands:\ extra life at >=20000
 SEC:RORextra_life_flag
 TXA:PHA
 JSRliveson
 INClives
 JSRliveson
 LDX#xlife MOD 256
 LDY#xlife DIV 256
 JSRmksound
 PLA:TAX
.not_ten_thousands
 JMPprint_scores
 
.xlife
 EQUW &13
 EQUW 3
 EQUW 129
 EQUW 30
 
.mult24tab
 EQUB 0*24:EQUB 1*24:EQUB 2*24
 EQUB 3*24:EQUB 4*24:EQUB 5*24
 EQUB 6*24:EQUB 7*24:EQUB 8*24
 EQUB 9*24
 
.check_new_high
 BITdemo_flag:BMInot_new_high
 LDX#&FF
.new_high1
 INX:CPX#7:BEQnot_new_high
.new_high2
 LDAmyscore,X:CMPhiscore,X
 BEQnew_high1
 BCCnot_new_high
.copy_to_high
 LDAmyscore,X:STAhiscore,X
 INX:CPX#7:BCCcopy_to_high
.not_new_high
 RTS
 
.reset_score_to_0
 LDY#6:LDA#0
.zero_my_score
 STAmyscore,Y
 DEY:BPLzero_my_score
 LDX#24*6+1
.clr_score_screen
 STA&308F,X
 DEX:BNEclr_score_screen
 LDA#&20:STAscreen
 LDA#&31:STAscreen+1
 LDX#6:JMPprint_scores
 
.toggle_demo_direct
 LDAdemo_direction:EOR#&80
 STAdemo_direction
 RTS
 
\ Points awarded for aliens
\ (divided by ten)
 
.alien_score
 EQUB2:EQUB2:EQUB2:EQUB2
 EQUB4:EQUB8:EQUB4:EQUB4
 EQUB6:EQUB8
 EQUB8:EQUB8
 
\\ ]
\\ PRINT"Routine 3  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
