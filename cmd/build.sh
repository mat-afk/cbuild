#!/usr/bin/env bash

SCOPE="build"

compile() {
    local source="$1"
    local object="$2"

    cmd=("$cc" -I$INCLUDE_DIR -Wall -Wextra -MMD -MP -c "$source" -o "$object")
    log_debug "${cmd[@]}"

    "${cmd[@]}"
}

link() {
    local objects=("$@")

    cmd=("$cc" "${objects[@]}" -o "$BIN")
    log_debug "${cmd[@]}"

    "${cmd[@]}"
}

build() {
    echo "Building project..."

    local objects=()

    verbose "Compiling C files..."
    verbose

    for source in $SRC_DIR/*.c; do
        local filename="$(basename "$source" .c)"
        local object="$OBJ_DIR/$filename.o"

        objects+=("$object")

        if [[ ! -f "$object" || "$source" -nt "$object" ]]; then
            log_debug "$source is newer than $object; recompiling..."

            compile "$source" "$object"
        fi
    done

    verbose "Linking objects..."
    verbose

    link "${objects[@]}"

    create_success_log "Project built successfully."
}

check_cc_and_throw "$cc"
build
