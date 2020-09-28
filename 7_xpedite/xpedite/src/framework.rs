use std::ffi::CString;

#[derive(PartialEq)]
pub enum FrameworkOption {
    AwaitProfileBegin,
}

pub fn initialize(app_info_file: &str, options: &[FrameworkOption]) -> Option<()> {
    let app_info_file = CString::new(app_info_file).expect("cstring");
    if options.contains(&FrameworkOption::AwaitProfileBegin) {
        if unsafe { ffi::framework_initialize_await(app_info_file.as_ptr()) } == 0 {
            return None;
        }
    }

    Some(())
}

pub fn initialize_with_ip(app_info_file: &str, listener_ip: &str, port: u16, options: &[FrameworkOption]) -> Option<()> {
    let app_info_file = CString::new(app_info_file).expect("cstring");
    let listener_ip = CString::new(listener_ip).expect("cstring");
    if options.contains(&FrameworkOption::AwaitProfileBegin) {
        if unsafe { ffi::framework_initialize_with_ip_await(app_info_file.as_ptr(), listener_ip.as_ptr(), port as i32) } == 0 {
            return None;
        }
    }

    Some(())
}

mod ffi {
    use std::os::raw::c_char;

    #[link(name="xpedite-pie")]
    extern "C" {
        pub fn framework_initialize_await(appInfoFile: *const c_char) -> i32;
        pub fn framework_initialize_with_ip_await(appInfoFile: *const c_char, listenerIp: *const c_char, port: i32) -> i32;
    }
}
