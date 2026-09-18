#!/usr/bin/env bash

check_cc_and_throw "$cc"

if [[ -f "$BIN" ]]; then
    "$BIN"
    create_info_log "The project has started running"
else
    throw_error missing_binaries
fi
