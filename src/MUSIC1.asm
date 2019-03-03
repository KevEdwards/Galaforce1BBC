\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"MUSIC1"
\\ B%=P%

 D1=0*64
 D2=1*64
 D3=2*64
 D4=3*64
 Rest=63
 
\\ [ OPT pass
 
 \===================================================================
 .StartTune
 SEI
      STY WK:LDA LT+0,Y:STA get+1:LDA LT+1,Y:STA get+2:LDA #0:STA IX+0
      LDA LT+2,Y:STA IX+1:LDA LT+3,Y:STA IX+2:LDX LT+4,Y:LDY #3
 .SL1 LDA SPT,X:STA SPD,Y:DEX:DEY:BPL SL1:LDY WK:LDX LT+5,Y:LDY #2
 .EL  LDA ENVTAB,X:STA ENV,Y:LDA #1:STA CNT,Y:DEX:DEY:BPL EL:LDY WK
      LDX LT+6,Y:LDY #2
 .DL  LDA DURATAB,X:STA DUR,Y:DEX:DEY:BPL DL
 CLI:RTS
 
 .Refresh
      LDX #2:STX WK
 .RL  LDX WK:DEC CNT,X:BNE NOC:LDY IX,X
 .get LDA &DDDD,Y:BEQ NOC:INC IX,X:PHA:AND #Rest:CMP #Rest:BEQ ST:PLA:PHA
      ASL A:ASL A
      STA SND+4:TXA:CLC:ADC #&11:STA SND+0:LDA ENV,X:STA SND+2:LDA DUR,X
      STA SND+6
 BIT sound_flag:BPL ST
 LDX #SND MOD 256:LDY #SND DIV 256:LDA #7:JSR &FFF1
 .ST  PLA:ROL A:ROL A:ROL A:AND #3:TAX:LDA SPD,X:LDX WK:STA CNT,X
 .NOC DEC WK:BPL RL
 RTS
 
 .MusicTest
      LDA get+1:STA dat+1:LDA get+2:STA dat+2:LDX #2:LDA #0:PHP
 .ML  LDY IX,X:PLP
 .dat ORA &FFFF,Y:PHP:DEX:BPL ML:PLP:RTS
 
 .Stop
      LDX #HAL MOD 256:LDY #HAL DIV 256:STX get+1:STY get+2:LDA #0:LDX #3
 .SL2 STA IX-1,X:DEX:BNE SL2:LDA #15:JMP &FFF4
 
 \====================================================================
 
 .SND EQUD &00DD00DD:EQUD &00DD00DD
 .WK  EQUB 0
 .CNT EQUS "012"
 .IX  EQUS "012"
 .SPD EQUS "0123"
 .SPT EQUB 5:EQUB 10:EQUB 15:EQUB 20\Lost a Life
      EQUB 100:EQUB 96:EQUB 93:EQUB 1\In Between Levels
      EQUB 7:EQUB 14:EQUB 21:EQUB 28\Game Over
      EQUB 8:EQUB 16:EQUB 24:EQUB 32
      EQUB 9:EQUB 18:EQUB 27:EQUB 36
      EQUB 4:EQUB 8:EQUB 12:EQUB 16\Game Start
      EQUB 3:EQUB 6:EQUB 9:EQUB 12\Demo Music Section "a"
 .ENV EQUS "012"
 .ENVTAB
      EQUB 5:EQUB 6:EQUB 7\Lost a Life
      EQUB 6:EQUB 6:EQUB 6\Game Start
      EQUB 4:EQUB 4:EQUB 4\In Between Levels
      EQUB 8:EQUB 8:EQUB 8\Game Over
      EQUB 6:EQUB 6:EQUB 5\Demo Music Section "a"
 .DUR EQUS "012"
 .DURATAB
      EQUB 10:EQUB 1:EQUB 1\Lost a Life
      EQUB 5:EQUB 3:EQUB 2\Game Start, Game Over
      EQUB 50:EQUB 50:EQUB 50\In Between Levels
      EQUB 1:EQUB 3:EQUB 10\Demo Music Section "a"
      EQUB 2:EQUB 3:EQUB 14\Demo Music Section "d"
 
 \Data Look-up Table
 \Contains all the gen pertaining to each individual tune.
 
 \Order is as follows:
 
 \Address of channel 1 data.         2
 \Offset from ch. 1 to ch. 2 data.   1
 \Offset from ch. 1 to ch. 3 data.   1
 \Index into speeds table            1
 \Index into envelopes table         1
 \Index into durations table         1
 
 \         Addr1      Index2           Index3      Speed   Env    Dur
 \Game Over Music & also Lost a Life Music
 
 .LOST1
      EQUB 51+D2:EQUB 52+D2:EQUB 51+D2:EQUB 49+D2
      EQUB 51+D2:EQUB 49+D2:EQUB 47+D2:EQUB 46+D2
      EQUB 44+D4:EQUB 39+D4:EQUB 32+D1
 .HAL EQUB 0
 .OVER1
      EQUB Rest+D2
 .OVER2
      EQUB Rest+D2
 .OVER3
 .LOST2
      EQUB 51+D1:EQUB 47+D1:EQUB 44+D1:EQUB 39+D1
      EQUB 47+D1:EQUB 44+D1:EQUB 39+D1:EQUB 35+D1
      EQUB 44+D1:EQUB 39+D1:EQUB 35+D1:EQUB 32+D1
      EQUB 39+D1:EQUB 35+D1:EQUB 32+D1:EQUB 27+D1
      EQUB 35+D1:EQUB 32+D1:EQUB 27+D1:EQUB 23+D1
      EQUB 27+D1:EQUB 25+D1:EQUB 23+D1:EQUB 22+D1
      EQUB 20+D1:EQUB 8+D1:EQUB 8+D1:EQUB 8+D1:EQUB 8+D1
      EQUB 0
 .LOST3
      EQUB 8+D4:EQUB 20+D4:EQUB 8+D2:EQUB 8+D2:EQUB 20+D4
      EQUB 8+D2:EQUB 8+D2:EQUB 20+D2:EQUB 8+D2:EQUB 8+D2
      EQUB 0
 
 \Between Levels Music
 
 .BETW1
      EQUB 00+D4:EQUB 01+D4:EQUB 02+D4:EQUB 03+D4
      EQUB 04+D4:EQUB 05+D4:EQUB 06+D4:EQUB 07+D4
      EQUB 08+D4:EQUB 09+D4:EQUB 10+D4:EQUB 11+D4
      EQUB 12+D4:EQUB 13+D4:EQUB 14+D4:EQUB 15+D4
      EQUB 16+D4:EQUB 17+D4:EQUB 18+D4:EQUB 19+D4
      EQUB 20+D1:EQUB 21+D4
      EQUB 0
 .BETW2
      EQUB 00+D4:EQUB 01+D4:EQUB 02+D4:EQUB 03+D4
      EQUB 04+D4:EQUB 05+D4:EQUB 06+D4:EQUB 07+D4
      EQUB 08+D4:EQUB 09+D4:EQUB 10+D4:EQUB 11+D4
      EQUB 12+D4:EQUB 13+D4:EQUB 14+D4:EQUB 15+D4
      EQUB 16+D4:EQUB 17+D4:EQUB 18+D4:EQUB 19+D4
      EQUB 20+D4:EQUB 21+D4:EQUB 22+D4:EQUB 23+D4
      EQUB 24+D2:EQUB 25+D4
      EQUB 0
 .BETW3
      EQUB 00+D4:EQUB 01+D4:EQUB 02+D4:EQUB 03+D4
      EQUB 04+D4:EQUB 05+D4:EQUB 06+D4:EQUB 07+D4
      EQUB 08+D4:EQUB 09+D4:EQUB 10+D4:EQUB 11+D4
      EQUB 12+D4:EQUB 13+D4:EQUB 14+D4:EQUB 15+D4
      EQUB 16+D4:EQUB 17+D4:EQUB 18+D4:EQUB 19+D4
      EQUB 20+D4:EQUB 21+D4:EQUB 22+D4:EQUB 23+D4
      EQUB 24+D4:EQUB 25+D4:EQUB 26+D4
      EQUB 27+D3:EQUB 28+D4
      EQUB 0
 
\\ ]
\\ PRINT"Music 1    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
