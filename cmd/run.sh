#!/usr/bin/env bash

check_cc_and_throw "$cc"

if [[ -f "$BIN" ]]; then
    "$BIN"
else
    throw_error missing_binaries
fi
