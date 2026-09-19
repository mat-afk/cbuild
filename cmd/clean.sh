#!/usr/bin/env bash

SCOPE="clean"

clean() {
    local temp=("$BIN" "$OBJ_DIR/*.o" "$OBJ_DIR/*.d")

    echo "Cleaning..."

    verbose
    verbose "RM  $output build/obj/*.o build/obj/*.d"

    for files in "${temp[@]}"; do
        rm -fv $files | log_debug
        log_info "Project cleaned with success."
    done
}

clean
