#!/bin/bash

set -x

cargo build --manifest-path ./xpedite/Cargo.toml --example life

cargo run --manifest-path ./xpedite/Cargo.toml --example life &

sleep 0.1
read -n 1 -r

rm -Rf /tmp/baseline

~/Telechargements/Source/Xpedite/scripts/bin/xpedite record -b /tmp/baseline -p xpedite/profileInfo.py -H 1

cargo run --manifest-path ./xpedite/Cargo.toml --example life &

~/Telechargements/Source/Xpedite/scripts/bin/xpedite record -p xpedite/profileInfoBench.py -H 1
