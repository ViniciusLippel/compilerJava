/*incluir o pacote onde a classe será criada*/
package exemplo;
import exemplo.sym; /* essa classe será criada pelo CUP */
import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%%
%public
%class Lexico
%cup
%function next_token
%implements sym
%full
%line
%column
%char

/* as funções abaixo sobrescrevem o construtor da classe Symbol para suporte de mais argumentos */
/* mais detalhes em: http://www2.cs.tum.edu/projects/cup/examples.php */
%{
    StringBuffer string = new StringBuffer();
    public Lexico(java.io.Reader in, ComplexSymbolFactory sf){
	this(in);
	symbolFactory = sf;
    }
    ComplexSymbolFactory symbolFactory;

    private Symbol symbol(String name, int sym) {
        return symbolFactory.newSymbol(name, sym, new Location(name,yyline+1,yycolumn+1), new Location(name,yyline+1,yycolumn+yylength()));
    }

    private Symbol symbol(String name, int sym, Object val) {
        Location left = new Location(name,yyline+1,yycolumn+1);
        Location right= new Location(name,yyline+1,yycolumn+yylength() );
        return symbolFactory.newSymbol(name, sym, left, right,val);
    }
    private Symbol symbol(String name, int sym, Object val,int buflength) {
        Location left = new Location(name,yyline+1,yycolumn+yylength()-buflength);
        Location right= new Location(name,yyline+1,yycolumn+yylength());
        return symbolFactory.newSymbol(name, sym, left, right,val);
    }
    private void error(String message) {
      System.out.println("Error at line "+(yyline+1)+", column "+(yycolumn+1)+" : "+message);
    }
%}

%eofval{
    return symbolFactory.newSymbol("EOF", EOF, new Location("EOF",yyline+1,yycolumn+1), new Location("EOF",yyline+1,yycolumn+1));
%eofval}

letras  = [a-zA-Z]
numeros = [0-9]
// new_line = \r|\n|\r\n
ws = [ \r\n\t]+
// eof     = [\n\r]
bool_literal = true | false
id_      = {letras}({letras}|{numeros})*
const   = 0 | [1-9][0-9]*


%state STRING

%%

/* regras de tradução - tokens */
<YYINITIAL>{ /* esse parâmetros para que o flex reconheça as palavras reservadas */

/* palavras reservadas */
"int"       {return symbol ("int", INT, new Integer(INT));}
"str"       {return symbol ("str", STR);}
"if"		{return symbol ("if", IF);}
"else"      {return symbol ("else", ELSE);}
"return"	{return symbol ("return", RETURN);}
"def"       {return symbol ("def", DEF);}
{bool_literal}   { return symbol("bool",BOOL, new Boolean(Boolean.parseBoolean(yytext()))); }
{id_}        {return symbol ("id", ID_, yytext());}
{const}     {return symbol ("const", CONST, new Integer(Integer.parseInt(yytext())));}
{ws}        {return symbol ("ws", WS);}
// {eof}		{return symbol ("eof", EOF);}

// /*operadores*/
 \"              { string.setLength(0); yybegin(STRING); }
","			{return symbol (",", COMMA);}
";"			{return symbol (";", SEMICOLON);}
"+"         {return symbol ("sum", SUM, SUM, new Integer(SUM));}  
"-"         {return symbol ("sub", SUB, SUB, new Integer(SUB));}  
"*"         {return symbol ("mult", MULT, MULT, new Integer(MULT));} 
"/"         {return symbol ("div", DIV, DIV, new Integer(DIV));}
"="         {return symbol ("=", ATT);} 
"=="        {return symbol ("==", EQ, new Integer(EQ));} 
"!="        {return symbol ("!=", NOTEQ, new Integer(NOTEQ));}
">"         {return symbol (">", MORET, new Integer(MORET));} 
"<"         {return symbol ("<", LESST, new Integer(LESST));}
">="        {return symbol (">=", MOREEQ, new Integer(MOREEQ));}
"<="        {return symbol ("<=", LESSEQ, new Integer(LESSEQ));}
"!"         {return symbol ("!", NOT, new Integer(NOT));}
"&"         {return symbol ("&", AND, new Integer(AND));}
"|"         {return symbol ("|", OR, new Integer(OR));}
"("			{return symbol ("(", LPAREM);}
")"			{return symbol (")", RPAREM);}
"{"			{return symbol ("{", LBRACE);}
"}"			{return symbol ("}", RBRACE);}
"//".*      {/* ignorar comentários */}
}


<STRING>{

\" {string.setLength(0); yybegin(YYINITIAL);return symbol("str",STR,string.toString(),string.length()); }
  [^\n\r\"\\]+ {string.append(yytext());}
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\                             { string.append('\\'); }
}

/* tratamento de erros */
[^]|\n        {  /* throw new Error("Caracter inválido <"+ yytext()+">");*/
		    error("Caracter inválido <"+ yytext()+">"+", na linha "+yyline+", coluna "+yycolumn);
} 
/* funções auxiliares */