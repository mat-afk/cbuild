#!/usr/bin/env bash

check_cc_and_throw "$cc"

SCOPE="run"

if [[ ! -f $BIN ]]; then
    throw_error missing_binaries
fi

"$BIN"
log_info "The project has started running."
