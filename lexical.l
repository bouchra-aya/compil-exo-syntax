%{
      /* ---- Partie déclrations en C ----*/
    #include<stdio.h>
    #include "syntax.tab.h"
    int nb_ligne=1;
    int nb_colonne=1;
%}
/* ---- Partie définitions des ERs ----*/
IDF [a-zA-Z]([a-zA-Z0-9_])*
cmntr "//".*
CST [0-9]+
chaine \'[^\']*\'
/* ---- Partie règles de traduction ----*/
%%
"Script" {nb_colonne+=yyleng; return SCRIPT; }
"Vars" {nb_colonne+=yyleng; return VARS; }
"Int" {nb_colonne+=yyleng; return INT; }
"Real" {nb_colonne+=yyleng; return REAL; }
"Code" {nb_colonne+=yyleng; return CODE; }
"Begin" {nb_colonne+=yyleng; return BEGIN; }
"Finish" {nb_colonne+=yyleng; return FINISH; }
{IDF} {if(yyleng<14){nb_colonne+=yyleng; return IDF; }else{printf("Erreur lexicale: idf %s trop long a la ligne %d\n",yytext,nb_ligne);}}
{cmntr} {}
{CST} {nb_colonne+=yyleng; return CST; }
{chaine} {nb_colonne+=yyleng; return CHAINE; }
"," {nb_colonne+=yyleng; return VG; }
":" {nb_colonne+=yyleng; return DEUXPTS; }
";" {nb_colonne+=yyleng; return PVG; }
"{" {nb_colonne+=yyleng; return ACC_OUV; }
"}" {nb_colonne+=yyleng; return ACC_FER; }
"(" {nb_colonne+=yyleng; return PAR_OUV; }
")" {nb_colonne+=yyleng; return PAR_FER; }
":=" {nb_colonne+=yyleng; return AFF; }
"/" {nb_colonne+=yyleng; return DIV; }
"*" {nb_colonne+=yyleng; return MULT; }
"+" {nb_colonne+=yyleng;return PLUS; }
[ \t] {nb_colonne+=yyleng;}
\n {nb_ligne++;nb_colonne=1;}
. {printf("Erreur lexicale sur l'entite %s a la ligne %d a la colonne %d\n",yytext,nb_ligne,nb_colonne);nb_colonne+=yyleng;}

%%
