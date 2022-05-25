package classes;

public class Command {
	
	private Attribution att;
	private If if_;
	private Function func;
	
	public Command(Attribution att) {
		this.att = att;
	}
	
	public Command(If if_) {
		this.if_ = if_;
	}
	
	public Command(Function func) {
		this.func = func;
	}
}
