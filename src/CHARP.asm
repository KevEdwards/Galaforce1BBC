\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"CHARP"
\\ B%=P%
\\ [OPT pass
 
.prnstr LDA strdat,Y:STA data
 LDA strdat+1,Y:STA data+1:LDY #0
 LDA (data),Y:STA addres
 INY:LDA (data),Y:STA addres+1
 INY:LDA (data),Y:STA length
 INY:LDA (data),Y:STA colour
.nxtchr
 LDA colour:AND #&AA:STA pixcolu+1
 INY
 
.prnchr LDA (data),Y:STY savey
 STA temp:ASLA:ASLA:ADC temp:TAX
 LDA #5:STA width
.pixcolum LDY #7
 LDA &700,X:STA temp:\ Address of character set (spacey)
 
.pixcolu LDA #0: \ colour bits
 ASL temp:BCC pixcol0
 EOR (addres),Y
 STA (addres),Y
.pixcol0 DEY:BPL pixcolu
 
 INX
 DEC width:BEQ chrdun
 LDA pixcolu+1:EOR colour:STA pixcolu+1
 AND #&AA:BEQ pixcolum
 LDA addres:CLC:ADC #8:STA addres
 BCC pixcolum:INC addres+1:BNE pixcolum
 
.chrdun
 LDA addres:CLC:ADC #8:STA addres
 BCC lab1:INC addres+1
.lab1 LDY savey:DEC length:BNE nxtchr
 RTS
 
.strdat EQUW paustxt
        EQUW SCRtext
        EQUW HItext
        EQUW entering_wave
        EQUW gameover
        EQUW pressspace
        EQUW galaforce
        EQUW myname
        EQUW letter_S_Q
        EQUW letter_K_J
        EQUW pressspace2
        EQUW finish1
        EQUW finish2
        EQUW finish3
        EQUW finish4
        EQUW copyr
        EQUW za
        EQUW zb
        EQUW zc
 
.paustxt
 EQUW &7FE8:EQUB1:EQUB60
 EQUB25
 
.SCRtext
 EQUW &3030:EQUB 3:EQUB 51
 EQUB28:EQUB12:EQUB27:\ 'SCR'
 
.HItext
 EQUW &3150:EQUB 2:EQUB 51
 EQUB17:EQUB18:\ 'HI'
 
.entering_wave
 EQUW &5108:EQUB 16:EQUB 63
 EQUB14:EQUB23:EQUB29:EQUB14:\ ENTE
 EQUB27:EQUB18:EQUB23:EQUB16:\ RING
 EQUB38:EQUB35:EQUB24:EQUB23:\  ZON
 EQUB14:EQUB38
.wave_text
 EQUB38:EQUB38
.gameover
 EQUW &4C58:EQUB 9:EQUB 60
 EQUB16:EQUB10:EQUB22:EQUB14:\ GAME
 EQUB38:EQUB24:EQUB31:EQUB14:\  OVE
 EQUB27:\ R
 
.pressspace
 EQUW &6760:EQUB 19:EQUB 12
 EQUB25:EQUB27:EQUB14:EQUB28:\ PRES
 EQUB28:EQUB38:EQUB28:EQUB25:\ S SP
 EQUB10:EQUB12:EQUB14:EQUB38:\ ACE
 EQUB24:EQUB27:EQUB38:EQUB15:\ OR F
 EQUB18:EQUB27:EQUB14:\ IRE
 
.pressspace2
 EQUW &6CF0:EQUB 7:EQUB 12
 EQUB29:EQUB24:EQUB38:EQUB25:\ TO P
 EQUB21:EQUB10:EQUB34:\ LAY
 
.galaforce
 EQUW &3FD8:EQUB 9:EQUB &F
 EQUB16:EQUB10:EQUB21:EQUB10:\ GALA
 EQUB15:EQUB24:EQUB27:EQUB12:EQUB14:\ FORCE
 
.myname
 EQUW &4488:EQUB 16:EQUB 60
 EQUB11:EQUB34:EQUB38:EQUB20:\ BY K
 EQUB14:EQUB31:EQUB18:EQUB23:\ EVIN
 EQUB38:EQUB14:EQUB13:EQUB32:\  EDW
 EQUB10:EQUB27:EQUB13:EQUB28:\ ARDS
 
.letter_S_Q
 EQUW &7FD0:EQUB 1:EQUB 3
.sound_letter
 EQUB 28
 
.letter_K_J
 EQUW &7FB8:EQUB 1:EQUB 60
.key_joy_letter
 EQUB 20
 
.finish1
 EQUW&5900:EQUB 6:EQUB &C3
 EQUB28:EQUB10:EQUB29:EQUB30:\ SATU
 EQUB27:EQUB23:\ RN
 
.finish2
 EQUW&58F0:EQUB 7:EQUB &C3
 EQUB11:EQUB10:EQUB29:EQUB29:\ BATT
 EQUB14:EQUB27:EQUB34:\ ERY
 
.finish3
 EQUW&5910:EQUB 5:EQUB &C3
 EQUB29:EQUB30:EQUB27:EQUB11:\ TURB
 EQUB24:\ 0
 
.finish4
 
.copyr
 EQUW&7678:EQUB 17:EQUB 51
 EQUB28:EQUB30:EQUB25:EQUB14:\SUPE
 EQUB27:EQUB18:EQUB24:EQUB27:\RIOR
 EQUB38:EQUB28:EQUB24:EQUB15:\ SOF
 EQUB29:EQUB32:EQUB10:EQUB27:\TWAR
 EQUB14:\ E
 
.za
 EQUW &FFFF:EQUB 1:EQUB 3
.zs
 EQUB &FF
 
.zb
 EQUW &FFFF:EQUB 21:EQUB 3
.zt
 EQUB 0:\ 1 to 8
 EQUB 38:\ space
 EQUS "1234567":\  Score
 EQUB 38:EQUB38:\ Spaces
 EQUS "1234567890":\ Name
 
.zc
 EQUW &3D00:EQUB 15:EQUB 60
 EQUB14:EQUB23:EQUB29:EQUB14:EQUB27:EQUB38:\ ENTER
 EQUB34:EQUB24:EQUB30:EQUB27:EQUB38:\ YOUR
 EQUB23:EQUB10:EQUB22:EQUB14:\ NAME
 
\\ ]
\\ PRINT"Char print from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800:RETURN
 
\\ REM 012345
\\ DATA &7F,&41,&41,&79,&7F
\\ DATA &00,&78,&7F,&00,&00
\\ DATA &79,&79,&49,&49,&4F
\\ DATA &63,&49,&49,&7F,&78
\\ DATA &1F,&11,&71,&7F,&10
\\ DATA &6F,&49,&49,&79,&79
\\ REM 6789
\\ DATA &7F,&49,&49,&49,&7B
\\ DATA &01,&01,&01,&79,&7F
\\ DATA &78,&4F,&49,&7F,&78
\\ DATA &0F,&09,&09,&79,&7F
\\ REM ABCDEF
\\ DATA &78,&7F,&09,&0F,&78
\\ DATA &7F,&79,&49,&4F,&78
\\ DATA &7F,&79,&41,&41,&63
\\ DATA &7F,&79,&41,&41,&7F
\\ DATA &7F,&79,&49,&49,&49
\\ DATA &7F,&79,&09,&09,&09
\\ REM GHIJKL
\\ DATA &7F,&79,&41,&49,&7B
\\ DATA &7F,&78,&08,&08,&7F
\\ DATA &00,&7F,&78,&00,&00
\\ DATA &70,&40,&40,&7F,&78
\\ DATA &7F,&78,&08,&0F,&78
\\ DATA &7F,&78,&40,&40,&40
\\ REM MNOPQR
\\ DATA &7F,&01,&7F,&01,&7F
\\ DATA &7F,&79,&01,&01,&7F
\\ DATA &7F,&41,&41,&43,&7F
\\ DATA &7F,&79,&09,&09,&0F
\\ DATA &7F,&41,&61,&61,&7F
\\ DATA &7F,&79,&09,&0F,&78
\\ REM STUVWX
\\ DATA &4F,&49,&49,&79,&79
\\ DATA &01,&01,&7F,&79,&01
\\ DATA &7F,&78,&40,&40,&7F
\\ DATA &0F,&7F,&40,&70,&0F
\\ DATA &7F,&40,&7F,&40,&7F
\\ DATA &77,&78,&08,&08,&77
\\ REM YZ.-(space)
\\ DATA &0F,&08,&78,&08,&0F
\\ DATA &7B,&79,&49,&49,&6F
\\ DATA &00,&00,&60,&00,&00
\\ DATA &08,&08,&08,&08,&08
\\ DATA &00,&00,&00,&00,&00
\\ REM ()
\\ DATA &00,&18,&66,&81,&00
\\ DATA &00,&81,&66,&18,&00
