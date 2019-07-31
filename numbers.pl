%numbers.pl
% This file contains the Persian spoken numbers and
% their identifiers. 0 - 1000 can be generated.

number([sefr], [zero]). % 0

number([yek], [ones]). % 1
number([do], [ones]). % 2
number([se], [ones]). % 3
number([chahar], [ones, teen, hundreds]). %4 / 14 / 400
number([panj], [ones]). %5
number([shesh], [ones, hundreds]). %6 / 600
number([haft], [ones]). %7
number([hasht], [ones]). %8
number([noh], [ones]). %9

number([dah], [tens, teenroot]). %10

number([yaz], [teen]). % 11
number([davaz], [teen]). % 12
number([siz], [teen]). % 13
number([poonz], [teen]). % 15
number([shoonz], [teen]). % 16
number([hif], [teen]). % 17
number([hij], [teen]). % 18
number([nooz], [teen]). % 19

number([bist], [tens]). % 20
number([si], [tens]). % 30
number([chehel], [tens]). % 40
number([panjah], [tens]). % 50
number([shast], [tens]). % 60
number([haftad], [tens]). % 70
number([hashtad], [tens]). % 80
number([navad], [tens]). % 90

number([sad], [hundreds, hundroot, rootless]). % 100
number([devist], [hundreds, rootless]). % 200
number([si], [hundreds]). % 300
number([pan], [hundreds]). % 500
number([heft], [hundreds]). % 700
number([hesht], [hundreds]). % 800
number([neh], [hundreds]). % 900

number([hezar], [thousands]). % 1000

connector(o).
