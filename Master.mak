\\
\\ Galaforce 1 BBC
\\
\\ (C) Kevin Edwards 1986-2019
\\

objstrt%	=&B00	\ Start of actual code, data is loaded below this later ( to &900 and &A00 )
objend%		=&3000	\ End of code, where the Downloader is positioned
objexec%	=&4000	\ Execution address when loaded to &1900 rather than &900 ( objend% + &1900 - &900 )

	INCLUDE "src\CONST.asm"
	INCLUDE "src\ZPWORK.asm"
	INCLUDE "src\ABSWORK.asm"
 
	 \\ Normal ASCII
	MAPCHAR ' ','Z', 32

	ORG objstrt% - &200
	INCBIN "object\O.SPFONT"

	ORG objstrt% - &100
	INCBIN "object\O.DIGITS"

	\\ Main Code block - source files assembled in the same order as the original
	ORG objstrt%
	INCLUDE "src\SPRITES.asm"
	INCLUDE "src\INIT.asm"
	INCLUDE "src\ALIENS1.asm"
	INCLUDE "src\ALIENS2.asm"
	INCLUDE "src\ALIENS3.asm"
	INCLUDE "src\ALIENS4.asm"
	INCLUDE "src\ROUT1.asm"
	INCLUDE "src\ROUT2.asm"
	INCLUDE "src\ROUT3.asm"
	INCLUDE "src\ROUT4.asm"
	INCLUDE "src\STARS.asm"
	INCLUDE "src\BOMBS1.asm"
	INCLUDE "src\BOMBS2.asm"
	INCLUDE "src\CHARP.asm"
	INCLUDE "src\FLAGS.asm"
	INCLUDE "src\MUSIC1.asm"
	INCLUDE "src\MUSIC2.asm"
	INCLUDE "src\MUSIC3.asm"
	INCLUDE "src\TITLE.asm"
	INCLUDE "src\HIGH.asm"
	INCLUDE "src\WAVE.asm"
	INCLUDE "src\PATT.asm"
	INCLUDE "src\PATDAT.asm"
	INCLUDE "src\VECTORS.asm"
	
	objcodeend = P%
	PRINT"Code start  = ",~objstrt%
	PRINT"End of code = ",~objcodeend-1
	PRINT"Length      = ",~objcodeend-objstrt%,"    (",objcodeend-objstrt%,") bytes"
	PRINT"Bytes left  = ",~&297A-objcodeend,"   (",&297A-objcodeend,") bytes"

	\\ Include the graphics object file ( From &297A to &2FFF )
	ORG &297A
	INCBIN "object\O.GRAPHIC"
	
	\\ Include the Downloader binary at its GENUINE load address
	ORG objend%
	INCBIN "O.DOWN"

	\\ SAVE out everything
	PRINT "Saving GAME ", ~objstrt% - &200, ~objend% + &200, ~objexec%, ~&1900
	SAVE "GAME", objstrt% - &200, objend% + &200, objexec%, &1900

	\\ Save Main Basic Loader ( gets tokenised first )
	PUTBASIC "bas_extra\LOADER.bas.txt","$.L"

	