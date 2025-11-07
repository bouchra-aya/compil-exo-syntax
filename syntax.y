%{
#include <stdio.h>
#include <stdlib.h>
extern int nb_ligne;
extern int nb_colonne;
int yylex();
int yyerror(char *msg);
%}

%token SCRIPT VARS CODE BEGIN FINISH
%token INT REAL
%token IDF CST CHAINE
%token VG DEUXPTS PVG
%token ACC_OUV ACC_FER
%token AFF PLUS MULT DIV PAR_OUV PAR_FER

%start main_program

%%

main_program:
    SCRIPT IDF PVG VARS declarations CODE bloc FINISH
    {
        printf("Syntaxe correcte !\n");
    }
;

declarations:
      declaration
    | declaration declarations
;

declaration:
    liste_id DEUXPTS type PVG
;

liste_id:
      IDF
    | IDF VG liste_id
;

type:
      INT
    | REAL
;

bloc:
    BEGIN ACC_OUV instructions ACC_FER
;


instructions:
      instruction
    | instruction instructions
;

instruction:
      affectation
    | ecriture
;


affectation:
    IDF AFF expression PVG
;


ecriture:
    IDF PAR_OUV CHAINE PAR_FER PVG
;


expression:
      expression PLUS expression
    | expression MULT expression
    | expression DIV expression
    | PAR_OUV expression PAR_FER
    | CST
    | IDF
;

%%

main()
{
    yyparse();
    int yyerror(char *msg)
}
{
    printf("Erreur syntaxique : %s à la ligne %d, colonne %d\n", msg, nb_ligne, nb_colonne);
    return 1;
}



