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

PROJECT_ROOT="$(find_project_root)" || [[ "$1" == "init" || "$1" == "" ]] || throw_error missing_source_files
SRC_DIR="$PROJECT_ROOT/src"
BUILD_DIR="$PROJECT_ROOT/build"
OBJ_DIR="$BUILD_DIR/obj"
BIN="$BUILD_DIR/app"
LOG_DIR="$PROJECT_ROOT/logs"

[[ -f "$PROJECT_ROOT/cbuild.conf" ]] && source "$PROJECT_ROOT/cbuild.conf"
