#!/bin/bash

set -x

cargo build --manifest-path ./xpedite/Cargo.toml --example life

cargo run --manifest-path ./xpedite/Cargo.toml --example life &

sleep 0.1
read -n 1 -r

~/Telechargements/Source/Xpedite/scripts/bin/xpedite record -p xpedite/profileInfo.py -H 1
