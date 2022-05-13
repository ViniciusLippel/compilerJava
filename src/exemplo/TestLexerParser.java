package exemplo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java.io.StringReader;
import java.util.Scanner;


import exemplo.Lexico;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
import exemplo.sym;

public class TestLexerParser {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// Exemplos
        
        // geração do analisador léxico
        //Main.generate(args);
        
        // pode ser feito dessa forma ou através da interface do JFLex
    
        
        // usar a linha de comando abaixo para geração do parser
        // java -jar java-cup-11b.jar -interface -parser Parser  -locations -dump -debug def.cup
        
    
        // Exemplo para testar o léxico
        /*try{
               Scanner tec = new Scanner(System.in);
               String s = tec.next();
               while (!s.equals("s")){
                    Reader entrada = new StringReader(s);
                    ComplexSymbolFactory symbolFactory = new ComplexSymbolFactory();
                    Lexico lexico = new Lexico(entrada,symbolFactory);
                    System.out.println("Token: "+sym.terminalNames[lexico.next_token().sym]);
                    System.out.println("Token: "+sym.terminalNames[lexico.next_token().sym]);
                    /*System.out.println("Token: "+sym.terminalNames[lexico.next_token().sym]);
                    s = tec.next();

              }
           }catch(Exception e){
               System.out.println("Erro na entrada: "+e.getMessage());
           }*/
        
        /*try {
        	String programa = "teste=0";
        	Lexico lex = new Lexico(new StringReader(programa),new ComplexSymbolFactory());
        	System.out.println("Token: "+sym.terminalNames[lex.next_token().sym]);
        	
        }catch(Exception e){
            System.out.println("Erro na entrada: "+e.getMessage());
        }*/
        
		try {
			String caminho = "/home/vinicius/eclipse-workspace/gramaticaJflexJcup/src/exemplo/teste.txt";
			BufferedReader bf = new BufferedReader(new FileReader(caminho));
			ComplexSymbolFactory csf = new ComplexSymbolFactory();
			Lexico lexico = new Lexico(bf, csf);
			//System.out.println("Token: "+sym.terminalNames[lexico.next_token().sym]);
			
			Parser p = new Parser(lexico, csf);
			Symbol i = p.debug_parse();
			System.out.println("Texto Correto. "+sym.terminalNames[i.sym]);
		}
		
        // Exemplo para testar o parser e léxico
        /*try{
            Scanner tec = new Scanner(System.in);
            String s = tec.next();
            ComplexSymbolFactory csf = new ComplexSymbolFactory();
            Reader entrada = new StringReader(s);
            Lexico lex = new Lexico(entrada,csf);
            //System.out.println("Token: "+sym.terminalNames[lex.next_token().sym]);    
            Parser p = new Parser(lex,csf);
            Symbol i = p.parse();
            s = tec.next();
            System.out.println("Texto Correto. "+sym.terminalNames[i.sym]);
        }*/catch(Exception e){
            System.out.println("\nErro: "+e.getMessage());
        }
	}

}
