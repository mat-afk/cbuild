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

    verbose "LD  build/obj/*.o $output"

    cmd=("$cc" "${objects[@]}" -o "$BIN")
    log_debug "${cmd[@]}"

    "${cmd[@]}"
}

build() {
    if [[ ! -d $SRC_DIR ]]; then
        throw_error missing_directory src
    fi

    if [[ ! -d $BUILD_DIR ]]; then
        throw_error missing_directory build
    fi

    if [[ ! -d $OBJ_DIR ]]; then
        throw_error missing_directory build/obj
    fi

    echo "Building project..."

    local objects=()

    verbose

    mapfile -t sources < <(find "$SRC_DIR" -type f -name "*.c")

    if [[ ${#sources[@]} == 0 ]]; then
        throw_error sources_missing
    fi

    for source in "${sources[@]}"; do
        local filename="$(basename "$source" .c)"
        local object="$OBJ_DIR/$filename.o"

        objects+=("$object")

        if [[ ! -f "$object" || "$source" -nt "$object" ]]; then
            log_debug "$filename.o does not exist or $filename.c is newer than $filename.o; recompiling..."

            verbose "CC  $filename.c"
            compile "$source" "$object"
        fi
    done

    link "${objects[@]}"

    log_info "Project built successfully."
}

check_cc_and_throw "$cc"
build
