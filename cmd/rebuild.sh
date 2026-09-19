#!/usr/bin/env bash

SCOPE="rebuild"

rebuild() {
    source "$CMD_DIR/clean.sh"
    source "$CMD_DIR/build.sh"

    log_info "Project rebuilt successfully."
}

rebuild
