#[macro_use]
extern crate rustler;
#[macro_use]
extern crate lazy_static;

extern crate mcrypto;
extern crate chrono;

use rustler::{NifEnv, NifTerm, NifResult, NifEncoder};
use chrono::prelude::*;
use mcrypto::ms_sha256 as sha256;

mod atoms {
    rustler_atoms! {
        atom ok;
    }
}

rustler_export_nifs! {
    "Elixir.Crypter",
    [("ms_sha256", 2, ms_sha256)],
    None
}

const MAGIC_KEY: u64 = 0x0e79a9c1;

fn ms_sha256<'a>(env: NifEnv<'a>, args: &[NifTerm<'a>]) -> NifResult<NifTerm<'a>> {
    let id: String = try!(args[0].decode());
    let key: String = try!(args[1].decode());

    let local: DateTime<Local> = Local::now();

    let ts = local.second();
    Ok((atoms::ok(), sha256(ts.to_string().as_str(), id.as_str(), key.as_str(), MAGIC_KEY)).encode(env))
}