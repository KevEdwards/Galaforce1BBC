cls

beebasm -i Prebuild.mak

beebasm -i Master.mak -di G1_BLANK.ssd -do Galaforce1BBC.ssd
@Echo. Done! .ssd image has been built
dir *.ssd
