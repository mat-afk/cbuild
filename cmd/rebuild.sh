#!/usr/bin/env bash

SCOPE="rebuild"

source "$CMD_DIR/clean.sh"
source "$CMD_DIR/build.sh"

rebuild() {
    clear
    build

    log_info "Project rebuilt successfully."
}

rebuild
