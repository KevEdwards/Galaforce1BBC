\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"STARS"
\\ B%=P%
\\ [OPT pass
 
.starinit
 LDX #90:LDY #30
 LDA #0:STA addres:STA addres+1:STA whichstar
.starin0
 JSR starpos
 JSR rand:AND #4:ORA addres:CLC:ADC stardat,X:STA stardat,X
 LDA addres+1:ADC stardat+1,X:STA stardat+1,X
 LDA addres:CLC:ADC #&80:STA addres
 LDA addres+1:ADC #2:STA addres+1
.gcol JSR rand:AND #&15:BEQ gcol
 STA stardat+2,X
 EOR (stardat,X):STA (stardat,X)
 DEX:DEX:DEX:DEY:BPL starin0
 RTS
 
 
.movestars
 LDY #16:LDX whichstar
 BEQ movestar:DEY
.movestar LDA stardat+2,X
 EOR (stardat,X):STA (stardat,X)
 LDA stardat,X:AND #7:CMP #7:BNE doapix
.notofb LDA stardat,X
 EOR#&40:ADC#&79:AND #&F8:STAstardat,X
 LDA stardat+1,X:EOR#1
 ADC #2:STA stardat+1,X
 BPL staron
 
.offbot
 JSR starpos
 JMP staron
 
.doapix INC stardat,X
.staron LDA stardat+2,X
 EOR (stardat,X):STA (stardat,X)
 INX:INX:INX:DEY:BNE movestar
 LDA whichstar:CLC:ADC #48
 CMP #96:BNE whstarin:LDA #0
.whstarin STA whichstar:RTS
 
.starpos JSR rand:AND #3:CMP #3:BEQstarpos
 CLC:ADC #&32:STA stardat+1,X
 CMP #&32:BEQ offb2
 JSR rand:AND #&F8:JMP offb3
.offb2 JSR rand:AND #&78:ORA #&80
.offb3 STA stardat,X:RTS
 
.rand LDA rand1:AND #&48:EOR&FC:ADC #&38
 ASLA:ASLA:ROL rand1+2:ROL rand1+1
 ROL rand1:LDA rand1:RTS
 
 
\\ ]
\\ PRINT"Stars      from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
