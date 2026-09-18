#!/usr/bin/env bash

compile() {
    local source="$1"
    local object="$2"

    cmd=("$cc" -Wall -Wextra -MMD -MP -c "$source" -o "$object")
    "${cmd[@]}"
}

link() {
    local objects=("$@")

    cmd=("$cc" "${objects[@]}" -o "$BIN")
    ${cmd[@]}
}

build() {
    local objects=()

    for source in $SRC_DIR/*.c; do
        local filename="$(basename "$source" .c)"
        local object="$OBJ_DIR/$filename.o"

        objects+=("$object")

        if [[ ! -f "$object" || "$source" -nt "$object" ]]; then
            compile "$source" "$object"
        fi
    done

    link "${objects[@]}"
}

check_cc_and_throw "$cc"
echo "Building project..."
build
create_build_log "Project build successfully"
