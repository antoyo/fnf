extern crate cc;
extern crate cpp_build;

fn main() {
    cc::Build::new()
        .file("wrappers/framework.cpp")
        .compile("xpedite_target");
    cpp_build::build("examples/life.rs");
}
