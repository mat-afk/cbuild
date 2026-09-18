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

command_needs_conf() {
    local command="$1"

    local commands_that_need_conf=(build run clean rebuild info)

    for command_that_need_conf in "${commands_that_need_conf[@]}"; do
        if [[ "$command" == "$command_that_need_conf" ]]; then
            return 0
        fi
    done

    return 1
}

PROJECT_ROOT=""

if command_needs_conf "$cmd"; then
    PROJECT_ROOT="$(find_project_root)" || throw_error missing_conf

    SRC_DIR="$PROJECT_ROOT/src"
    INCLUDE_DIR="$PROJECT_ROOT/include"
    BUILD_DIR="$PROJECT_ROOT/build"
    OBJ_DIR="$BUILD_DIR/obj"
    DOCS_DIR="$PROJECT_ROOT/docs"
    LOGS_DIR="$PROJECT_ROOT/logs"

    BIN="$BUILD_DIR/app"

    if [[ -f "$PROJECT_ROOT/cbuild.conf" ]]; then
        source "$PROJECT_ROOT/cbuild.conf"
        BIN="$BUILD_DIR/$output"
    fi
fi
