\\
\\ Galaforce 1 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1986-2019
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"ALIENS4"
\\ B%=P%
\\ [OPT pass
 
.actiontab
 EQUW dat_loop
 EQUW dat_newpat
 EQUW dat_newalien
 EQUW dat_die
 EQUW dat_dropbomb
 EQUW dat_for_loop
 EQUW dat_next
 EQUW mve
 
.dat_loop
 INCalpatoff,X:LDA(temp2),Y
 STAalpatoff,X
 JMPmove7
 
.dat_newpat
 INCalpatoff,X:LDA(temp2),Y
 TAY
 LDAvecpatdl,Y:STAalpatlow,X
 LDAvecpatdh,Y:STAalpathigh,X
 LDA#0:STAalpatoff,X
 JMPmove7
 
.dat_newalien
 INCalpatoff,X:LDA(temp2),Y
 STAtemp1
 LDYaliensm1
.dat_newal2
 LDAalst,Y:BPLdat_newal3
 DEY:BPLdat_newal2
 BMIdat_newal4
 
.dat_newal3
 LDA#&80:STAalst,Y
 ASLA:STAalmult,Y
 STAalpatoff,Y
 JSRrand:AND#2:STAtemp1+1
 CLC:ADC#12
 STAalgra,Y:STAtemp3
 LDAalpatreflect,X:STAalpatreflect,Y
 LDAalx,X:PHA:STAalx,Y
 LDAaly,X:ADC#8:STAaly,Y:PHA
 LDXtemp1
 LDAvecpatdl,X:STAalpatlow,Y
 LDAvecpatdh,X:STAalpathigh,Y
 LDAtemp1+1:LSRA:TAX
 LDAalien_hits,X:STAalcount,Y
 PLA:TAY
 PLA:TAX
 INCalmove
 JSRalien_on_off
 LDXprocst
.dat_newal4
 JMPmove5
 
.dat_die
 LDAalst,X
 ORA#1:STAalst,X
 JMPmove5
 
.dat_dropbomb
 JSRrand:AND#3:BNEnot_allowed
 JSRinit_bomb
 LDXprocst
.not_allowed
 JMPmove7
 
.dat_for_loop
 INCalpatoff,X:LDA(temp2),Y
 STAal_loop_count,X
 INY:TYA:STAal_loop_start,X
 JMPmove7
 
.dat_next
 DECal_loop_count,X
 BMIend_of_loop
 LDAal_loop_start,X
 STAalpatoff,X
.end_of_loop
 JMPmove7
 
.mve
 LDAalx,X:LDYaly,X:TAX
 JSRxycalc
 STAscreen+1:STXscreen
 LDXprocst
 LDA#72:STAaly,X:TAY
 LDA#0:STAalx,X
 JMPdalg
 
\\ ]
\\ PRINT"Aliens 4   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=&5800
\\ RETURN
