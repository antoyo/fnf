#[macro_use]
extern crate cpp;
extern crate xpedite;

use xpedite::{framework, FrameworkOption, scope};

cpp!{{ #include <xpedite/framework/Probes.H> }}

scope!(EatScope, cpp!([] { XPEDITE_TXN_BEGIN(EatBegin); }), cpp!([] { XPEDITE_TXN_END(EatEnd); }));

fn eat() {
    let _scope = EatScope::new();
    println!("eat...");
    unsafe { cpp!([] { XPEDITE_PROBE(EatMoreBegin); }) };
    println!("eat more...");
    unsafe { cpp!([] { XPEDITE_PROBE(EatEvenMoreBegin); }) };
    println!("eat even more...");
}

fn sleep() {
    println!("sleep...");
}

fn code() {
    println!("code...");
}

scope!(LifeScope, cpp!([] { XPEDITE_TXN_BEGIN(LifeBegin); }), cpp!([] { XPEDITE_TXN_END(LifeEnd); }));

fn life(time_to_live: i32) {
    for _ in 0..time_to_live {
        eat();

        let _scope = LifeScope::new(); // LifeBegin

        unsafe { cpp!([] { XPEDITE_PROBE(SleepBegin); }) }; // SleepBegin
        sleep();

        unsafe { cpp!([] { XPEDITE_PROBE(CodeBegin); }) }; // SleepEnd
        code();

        // LifeEnd
    }
}

fn main() {
    framework::initialize("/tmp/xpedite-appinfo.txt", &[FrameworkOption::AwaitProfileBegin]).expect("initialize xpedite");
    life(100);
}
