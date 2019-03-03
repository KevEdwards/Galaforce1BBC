\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE":2.HIGH"
\\ B%=P%
\\ [OPT pass
 
.ahigh
 BITdemo_flag:BMIahdem
 LDX#0:STXtemp1
.ah1
 LDAti10,X:STAtemp2
 LDYti7,X:STYtemp1+1
 LDX#&FF
.ah2
 INY:INX:CPX#7:BEQah4
 LDAmyscore,X:AND#&7F:CMPhsnum,Y
 BEQah2
 BCCah3
 BNEah4
.ah3
 INCtemp1
 LDXtemp1:CPX#8:BCCah1
.ahdem
 RTS
 
.ah4
 LDAtemp1+1:CMP#7*7-1:BEQah5
 LDY#7*7-1
.ah6
 LDAhsnum,Y:STAhsnum+7,Y
 DEY:CPYtemp1+1:BNEah6
 
 LDY#10*7-1
.ah7
 LDAhstxt,Y:STAhstxt+10,Y
 DEY:CPYtemp2:BNEah7
 
.ah5
 LDX#0:LDYtemp1+1:INY
.ah8
 LDAmyscore,X:AND#&7F:STAhsnum,Y
 INY:INX:CPX#7:BNEah8
 LDX#9:LDYtemp2:INY
 TYA:PHA
 LDA#38:\ My space character
.ah9
 STAhstxt,Y
 INY:DEX:BPLah9
 LDAtemp1
 ASLA:ASLA:ASLA:ASLA
 CLC:ADC#9*8:PHA
 JSRpht
 LDY#36:JSRprnstr
 PLA:TAY:LDX#41
 JSRxycalc2
 STAza+1:STXza
 PLA:TAX
 JSRgnam
 LDY#36:JSRprnstr
 JMPpht
 
.pht
 LDA#0:STAwavbase
 LDA#&46:STAzb+1
 LDA#&C0:STAzb
.ai1
 LDXwavbase:INX:STXzt
 DEX:LDYti7,X:INY
 LDX#0:STXwavbase+1
.ai2
 LDAhsnum,Y:BNEph2
 CMPwavbase+1:BNEph2
 LDA#38:BNEph3
.ph2
 SEC:RORwavbase+1
.ph3
 STAzt+2,X
 INY:INX:CPX#7:BNEai2
 LDXwavbase:LDYti10,X:INY
 LDX#0
.ai3
 LDAhstxt,Y:STAzt+11,X
 INY:INX:CPX#10:BNEai3
 LDY#34:JSRprnstr
 LDAzb+1:CLC:ADC#5:STAzb+1
 INCwavbase
 LDAwavbase:CMP#8:BCCai1
 RTS
 
.gnam
 LDY#10:BNEgn1
.gn3
 LDA#7:JSRoswrch
.gn1
 STXwavbase:STYwavbase+1
 LDA#21:LDX#0:JSRosbyte
.gn6
 JSRmovestars
 LDA#&7E:JSRosbyte
 LDA#&81:LDX#2:LDY#0:JSRosbyte
 BCSgn6
 TXA
 LDXwavbase:LDYwavbase+1
 CMP#&D:BEQgn2
 CMP#&7F:BEQhdel
 CPY#0:BEQgn3
 CMP#' ':BNEgn7
 LDA#38:BNEgn8
.gn7
 CMP#'A':BCCgn9
 CMP#'Z'+1:BCSgn3
 SBC#54:BNEgn8
.gn9
 CMP#'0':BCCgn3
 CMP#'9'+1:BCSgn3
 SBC#'0'-1
.gn8
 STAzs:STAhstxt,X
 JSRpit
 LDAza:CLC:ADC#24:STAza
 BCCgn4
 INCza+1
.gn4
 INX:DEY:BPLgn1
.gn2
 RTS
 
.hdel
 CPY#10:BEQgn3
 LDAza:SEC:SBC#24:STAza
 BCSgn5
 DECza+1
.gn5
 INY:DEX
 LDAhstxt,X:STAzs
 JSRpit
 LDA#38:\ space
 STAhstxt,X
 JMPgn1
 
.pit
 TXA:PHA:TYA:PHA
 LDY#32:JSRprnstr
 PLA:TAY:PLA:TAX
 RTS
 
.ti7
 EQUB0-1:EQUB7-1:EQUB14-1:EQUB21-1
 EQUB28-1:EQUB35-1:EQUB42-1:EQUB49-1
 
.ti10
 EQUB0-1:EQUB10-1:EQUB20-1:EQUB30-1
 EQUB40-1:EQUB50-1:EQUB60-1:EQUB70-1
 
\\ ]
\\ PRINT"High       from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800:RETURN
