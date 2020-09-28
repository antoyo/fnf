pub mod framework;

pub use framework::FrameworkOption;

#[macro_export]
macro_rules! scope {
    ($name:ident, $begin:expr, $end:expr) => {
        struct $name;

        impl $name {
            fn new() -> Self {
                unsafe { $begin };
                $name
            }
        }

        impl Drop for $name {
            fn drop(&mut self) {
                unsafe { $end };
            }
        }
    };
}

/* TODO: would be cool to have, but https://github.com/mystor/rust-cpp/issues/19
#[macro_export]
macro_rules! txn_scope {
    ($name:ident) => {{
        struct Scope;

        impl Scope {
            fn new() -> Self {
                unsafe { cpp!([] { XPEDITE_TXN_BEGIN(concat_idents!($name, Begin)); }) };
                Self
            }
        }

        impl Drop for Scope {
            fn drop(&mut self) {
                unsafe { cpp!([] { XPEDITE_TXN_END(concat_idents!($name, End)); }) };
            }
        }

        Scope
    }};
}
*/
