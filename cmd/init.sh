#!/usr/bin/env bash

scaffold_main() {
    local target_dir="$1"
    local src_dir="$target_dir/src"

    if [[ -z "$(ls -A "$src_dir" 2>/dev/null)" ]]; then
        cp "$CBUILD_ROOT/resources/main.template.c" "$src_dir/main.c"
    fi
}

init() {
    local target_dir="${2:-$PWD}"

    if [[ -f "$target_dir/cbuild.conf" ]]; then
        die "$target_dir is already a cbuild project (found cbuild.conf)"
    fi

    echo "Creating new cbuild project..."
    echo

    local default_name="$(basename "$target_dir")"
    local project_name="$(prompt "Project name" "$default_name")"
    local binary_name="$(prompt "Binary name" "$project_name")"

    local cc="$(prompt "Compiler" "gcc")"

    echo

    local dirs=(src include build)
    for d in "${dirs[@]}"; do
        mkdir -p "$target_dir/$d"
    done

    echo "directory structure created (src/, include/, build/)"
    echo

    sed \
        -e "s|@@PROJECT@@|$project_name|g" \
        -e "s|@@BINARY@@|$binary_name|g" \
        -e "s|@@CC@@|$cc|g" \
        "$CBUILD_ROOT/resources/cbuild.template.conf" > "$target_dir/cbuild.conf"

    scaffold_main "$target_dir"

    echo "project '$project_name' inicialized in $target_dir"
}

init "$@"
