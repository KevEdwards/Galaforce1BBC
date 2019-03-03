\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE":2.TITLE"
\\ B%=P%

titcol=3

\\ [OPT pass
 
.title
 LDA#&70:STAtemp2
 LDA#&F0:STAtemp3
 LDA#&3A:STAtemp2+1
 LDA#&3C:STAtemp3+1
 LDX#0:STXtemp4+1
.gchr
 LDXtemp4+1
 LDAtitnam,X:BMItit6
 STAtemp1
 ASLA:ASLA:CLC:ADCtemp1
 TAX
 LDA#5:STAtemp4
.tit1
 LDA&700,X:STAtemp1
 LDA#4:STAtemp1+1
 LDY#0
.tit2
 LSRtemp1:BCCtit3
 LDA#titcol
 EOR(temp2),Y
 STA(temp2),Y
 INY
 LDA#titcol
 EOR(temp2),Y
 STA(temp2),Y
 DEY
.tit3
 LDA#8:ANDtemp1
 BEQtit4
 LDA#titcol
 EOR(temp3),Y
 STA(temp3),Y
 INY
 LDA#titcol
 EOR(temp3),Y
 STA(temp3),Y
 DEY
.tit4
 INY:INY
 DECtemp1+1:BNEtit2
 JSRtitrig:INX
 DECtemp4:BNEtit1
 JSRtitrig
 INCtemp4+1:BNEgchr:\ always
 
.titrig
 LDAtemp2
 CLC:ADC#8:STAtemp2
 BCCtit5
 INCtemp2+1
.tit5
 LDAtemp3
 CLC:ADC#8:STAtemp3
 BCCtit6
 INCtemp3+1
.tit6
 RTS
 
.titnam
 EQUB16:EQUB10:EQUB21:EQUB10:\GALA
 EQUB15:EQUB24:EQUB27:EQUB12:\FORC
 EQUB14:EQUB&FF:\E

\\ ]
\\ PRINT"Title      from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800:RETURN
