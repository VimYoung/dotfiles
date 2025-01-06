use std::env;
// use std::os::unix::process;
use std::process;
use std::time;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args[1] == "time" {
        println!("THe time argument is given.");
        match args[2].as_str() {
            "hello" => println!("Arg is hello"),
            _ => println!("no good arg given"),
        }
        process::exit(0);
    }
}
