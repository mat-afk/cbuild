#!/usr/bin/env bash

SCOPE="rebuild"

source "$CMD_DIR/clean.sh"
source "$CMD_DIR/build.sh"

rebuild() {
    clear
    build

    create_info_log "Project rebuilt successfully."
}

rebuild
