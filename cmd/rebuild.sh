#!/usr/bin/env bash

source "$CMD_DIR/clean.sh"
source "$CMD_DIR/build.sh"

rebuild()
{
    clear
    build
    create_build_log "Project rebuilt successfully"
}

rebuild
