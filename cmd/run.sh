#!/usr/bin/env bash

SCOPE="run"

check_cc_and_throw "$cc"

source "$CMD_DIR/build.sh"

if [[ ! -f $BIN ]]; then
    throw_error missing_binaries
fi

"$BIN"
log_info "The project has started running."
