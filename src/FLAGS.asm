\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"FLAGS"
\\ B%=P%
\\ [OPT pass
 
.liveson LDX lives:BEQ noliveson
 LDA #&7D:STA addres+1:LDA #&63:STA addres
.liveon0 LDY #28
.liveon1 LDA shipgra,Y:EOR(addres),Y:STA(addres),Y:DEY:BPL liveon1
 LDAaddres:SEC:SBC#32:STAaddres
 DEX:BNE liveon0
.noliveson RTS
 
.flagson LDYcurwave:INY:STYtemp
 LDA#&7B:STAaddres+1:LDA#0:STAaddres
 LDA#&7D:STAaddres1+1:LDA#&80:STAaddres1
 
.flag0 LDAtemp:BEQnomoflags
 CMP#10:BCCflag1
 SEC:SBC#10:STAtemp
 LDX#0
.flago0 LDY#31
.flago1 LDAflaggra,X:EOR(addres),Y:STA(addres),Y
 INX:DEY:CPY#8:BNE flago1
 LDA#51:EOR(addres1),Y:STA(addres1),Y
 DEY
.poleon LDA#1:EOR(addres),Y:STA(addres),Y
 LDA#1:EOR(addres1),Y:STA(addres1),Y:DEY:BPL poleon
 LDY#9:LDAflaggra,X:INX:EOR(addres1),Y:STA(addres1),Y
 LDY#16:LDAflaggra,X:INX:EOR(addres1),Y:STA(addres1),Y:INY
 LDAflaggra,X:INX:EOR(addres1),Y:STA(addres1),Y
 LDY#24:LDAflaggra,X:EOR(addres1),Y:STA(addres1),Y
 LDAaddres:CLC:ADC#32:STAaddres:LDAaddres+1:ADC#0:STAaddres+1
 LDAaddres1:CLC:ADC#32:STAaddres1:LDAaddres1+1:ADC#0:STAaddres1+1:BNEflag0
.nomoflags RTS
 
.flag1 CMP#5:BCCflag2:SEC:SBC#5:STAtemp:LDX#27:BNEflago0
.flag2 SEC:SBC#1:STAtemp:LDX#54:BNEflago0
 
.flaggra EQUB49:EQUB49:EQUB49:EQUB49:EQUB49:EQUB34:EQUW0
 EQUB48:EQUB49:EQUB49:EQUB49:EQUB48:EQUB51:EQUB34:EQUB0
 EQUB49:EQUB49:EQUB49:EQUB49:EQUB49:EQUB51:EQUB51
 EQUB51:EQUB51:EQUB34:EQUB34
 
 EQUB0:EQUB34:EQUB34:EQUB34:EQUD0
 EQUB49:EQUB49:EQUB49:EQUB51:EQUB49:EQUB34:EQUW0
 EQUB50:EQUB51:EQUB50:EQUB50:EQUB50:EQUB51:EQUB51
 EQUB51:EQUB34:EQUW0
 
 EQUW0:EQUB34:EQUD0:EQUB0
 EQUB34:EQUB51:EQUB51:EQUB51:EQUB34:EQUW0:EQUB0
 EQUB50:EQUB50:EQUB50:EQUB50:EQUB50:EQUB51:EQUB34
 EQUB34:EQUW0:EQUB0
 
.shipgra EQUB2:EQUB63:EQUB63:EQUB46:EQUB8
 EQUB17:EQUB21:EQUB30:EQUB56:EQUB60:EQUB60:EQUB15:EQUB10
 EQUW0:EQUB10:EQUB40:EQUB61:EQUB61:EQUB14:EQUB10
 EQUW0:EQUB0:EQUB2:EQUB42:EQUB42:EQUB42:EQUB8
 
\\ ]
\\ PRINT"Flags etc. from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
