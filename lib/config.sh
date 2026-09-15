#!/usr/bin/env bash

find_project_root() {
    local dir="$(pwd)"

    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/cbuild.conf" ]]; then
            echo "$dir"
            return 0
        fi

        dir="$(dirname "$dir")"
    done

    return 1
}

PROJECT_ROOT="$(find_project_root)" || [[ "$1" == "init" ]] || {
    echo "error: this is not a cbuild project (run 'cbuild init')" >&2
    exit 1
}
SRC_DIR="$PROJECT_ROOT/src"
BUILD_DIR="$PROJECT_ROOT/build"
OBJ_DIR="$BUILD_DIR/obj"
BIN="$BUILD_DIR/app"

[[ -f "$PROJECT_ROOT/cbuild.conf" ]] && source "$PROJECT_ROOT/cbuild.conf"
