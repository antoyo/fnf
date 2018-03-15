use std::env;
use std::fs::File;
use std::io::Read;

fn main() {
    let cmd = "check";
    let mut args = env::args();
    let program_name = args.next().expect("program name");
    let byte: i32 =
        match args.next() {
            Some(byte) => byte.parse().unwrap_or(10),
            None => {
                eprintln!("Please provide a number (byte) to check");
                return;
            },
        };
    let mut file = File::open(program_name).expect("File open");
    let mut binary = vec![];
    file.read_to_end(&mut binary).expect("File read");
    match cmd {
        "check" if check_binary(binary, byte) => {
            println!("10 bob");
        },
        _ => {
            // Check again just to make sure.
            if !check_binary(binary, byte) {
                println!("Byte not find in binary");
            }
        },
    }
}

fn check_binary(binary: Vec<u8>, byte: i32) -> bool {
    let byte =
        if byte == 0 {
            1
        }
        else {
            byte
        } << 16;
    binary.iter().any(|&program_byte| program_byte as i32 == byte)
}
