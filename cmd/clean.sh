#!/usr/bin/env bash

SCOPE="clean"

clean() {
    local temp=("$BIN" "$OBJ_DIR/*.o" "$OBJ_DIR/*.d")

    echo "Cleaning..."

    for files in "${temp[@]}"; do
        rm -fv $files
        create_success_log "Project cleaned with success."
    done
}

clean
