flex lexical.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -o ACAD_B_G2 -lfl
ACAD_B_G2.exe < test.txt
