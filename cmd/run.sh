#!/usr/bin/env bash

SCOPE="run"

check_cc_and_throw "$cc"

there_are_newer_sources() {
    for file in "$SRC_DIR/*.c"; do
        if [[ $file -nt $BIN ]]; then
            return 0
        fi
    done

    return 1
}

if [[ ! -f $BIN || $(there_are_newer_sources) ]]; then
    log_debug "There are newer sources, rebuilding."

    source "$CMD_DIR/build.sh"
    echo
fi

if [[ ! -f $BIN ]]; then
    throw_error missing_binaries
fi

"$BIN"
log_info "The project has started running."
