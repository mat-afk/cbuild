#!/usr/bin/env bash

prompt_cc() {
    local cc
    local is_cc_valid=false

    until $is_cc_valid; do
        cc="$(prompt "Compiler" gcc)"

        if [[ "$cc" != "gcc" && "$cc" != "clang" ]]; then
            throw_error invalid_compiler
        else
            check_cc "$cc" && is_cc_valid=true || throw_error missing_cc
        fi
    done

    echo "$cc"
}

scaffold_conf() {
    local target_dir="$1"
    local project_name="$2"
    local binary_name="$3"
    local cc="$4"

    sed \
        -e "s|@@PROJECT@@|$project_name|g" \
        -e "s|@@BINARY@@|$binary_name|g" \
        -e "s|@@CC@@|$cc|g" \
        "$RES_DIR/cbuild.template.conf" > "$target_dir/cbuild.conf"
}

scaffold_main() {
    local target_dir="$1"
    local src_dir="$target_dir/src"

    [[ ! -d "$src_dir" ]] && mkdir -p "$src_dir"

    if [[ -z "$(ls -A "$src_dir" 2>/dev/null)" ]]; then
        cp "$RES_DIR/main.template.c" "$src_dir/main.c"
    fi
}

scaffold_tests() {
    local target_dir="$1"
    local tests_dir="$target_dir/tests"

    [[ ! -d "$tests_dir" ]] && mkdir -p "$tests_dir"

    if [[ -z "$(ls -A "$tests_dir" 2>/dev/null)" ]]; then
        cp "$RES_DIR/main_test.template.c" "$tests_dir/main_test.c"
    fi
}

scaffold_docs() {
    local target_dir="$1"
    local project_name="$2"
    local docs_dir="$target_dir/docs"

    [[ ! -d "$docs_dir" ]] && mkdir -p "$docs_dir"

    sed \
        -e "s|@@PROJECT@@|$project_name|g" \
        "$RES_DIR/README.template.md" > "$docs_dir/README.md"
}

scaffold_logs() {
    local target_dir="$1"
    local logs_dir="$target_dir/logs"

    [[ ! -d "$logs_dir" ]] && mkdir -p "$logs_dir"
    [[ ! -f "$logs_dir/cbuild.log" ]] && touch "$logs_dir/cbuild.log"
}

init() {
    local target_dir="${2:-$PWD}"

    if [[ -f "$target_dir/cbuild.conf" ]]; then
        die "Current directory ($target_dir) is already a cbuild project (found cbuild.conf)"
    fi

    verbose "Creating new cbuild project..."
	verbose "" 

    local default_name="$(basename "$target_dir")"
    local project_name="$(prompt "Project name" "$default_name")"
    local binary_name="$(prompt "Binary name" "$project_name")"
    local cc="$(prompt_cc)"

    local dirs=(src include build build/obj tests docs)
    for d in "${dirs[@]}"; do
        mkdir -p "$target_dir/$d"
    done
	
	verbose "" 
    verbose "Directory structure created (src/, include/, build/, tests/, docs/, logs/)"
	verbose "" 

    scaffold_conf "$target_dir" "$project_name" "$binary_name" "$cc"
    scaffold_main "$target_dir"
    scaffold_tests "$target_dir"
    scaffold_docs "$target_dir" "$project_name"
    scaffold_logs "$target_dir"

    LOG_DIR="$target_dir/logs"
    LOG_FILE="$LOG_DIR/cbuild.log"

    create_success_log "Project initiated"

    verbose "Project '$project_name' initialized in $target_dir"
}

init "$@"
