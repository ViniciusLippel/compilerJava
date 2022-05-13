package exemplo;

import jflex.exceptions.SilentExit;

public class GenerateLexer {
	public static void main(String[] args) {
		try {
			jflex.Main.generate(args);
		} catch (SilentExit e) {
			e.printStackTrace();
		}
		
		/* para geração do parser
		 * java -jar java-cup-11b.jar -interface -parser Parser  -locations -dump -debug def.cup
		 */
	}
}
