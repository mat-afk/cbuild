#!/usr/bin/env bash

SCOPE="init"

prompt_cc() {
    local cc
    local is_cc_valid=false

    until $is_cc_valid; do
        cc="$(prompt "Compiler" gcc)"

        if [[ "$cc" != "gcc" && "$cc" != "clang" ]]; then
            throw_error invalid_cc
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

    log_debug "Scaffolding cbuild.conf..."

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
        log_debug "Scaffolding src/main.c"
        cp "$RES_DIR/main.template.c" "$src_dir/main.c"
    fi
}

scaffold_include() {
    local target_dir="$1"
    local include_dir="$target_dir/include"

    [[ ! -d "$include_dir" ]] && mkdir -p "$include_dir"
}

scaffold_tests() {
    local target_dir="$1"
    local tests_dir="$target_dir/tests"

    [[ ! -d "$tests_dir" ]] && mkdir -p "$tests_dir"

    if [[ -z "$(ls -A "$tests_dir" 2>/dev/null)" ]]; then
        log_debug "Scaffolding tests/main_test.c"
        cp "$RES_DIR/main_test.template.c" "$tests_dir/main_test.c"
    fi
}

scaffold_docs() {
    local target_dir="$1"
    local project_name="$2"
    local docs_dir="$target_dir/docs"

    [[ ! -d "$docs_dir" ]] && mkdir -p "$docs_dir"

    log_debug "Scaffolding docs/README.md"

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
        throw_error already_initialized "$target_dir"
    fi

    echo "Creating new cbuild project..."
	echo

    local default_name="$(basename "$target_dir")"
    local project_name="$(prompt "Project name" "$default_name")"
    local binary_name="$(prompt "Binary name" "$project_name")"
    local cc="$(prompt_cc)"

    LOGS_DIR="$target_dir/logs"
    mkdir -p $LOGS_DIR

    LOG_FILE="$LOGS_DIR/$LOG_FILE_NAME"

    local dirs=(src/ include/ build/ build/obj/ tests/ docs/ logs/)
    for d in "${dirs[@]}"; do
        log_debug "Creating directory $dir"
        mkdir -p "$target_dir/$d"
    done

	echo
    echo "Directory structure created (${dirs[*]})"
	echo

    scaffold_conf "$target_dir" "$project_name" "$binary_name" "$cc"
    scaffold_main "$target_dir"
    scaffold_include "$target_dir"
    scaffold_tests "$target_dir"
    scaffold_docs "$target_dir" "$project_name"
    scaffold_logs "$target_dir"

    local msg="Project initialized sucessfully."
    echo "$msg"
    log_info "$msg"
}

init "$@"
