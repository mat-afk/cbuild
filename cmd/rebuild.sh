#!/usr/bin/env bash

source "$CMD_DIR/clean.sh"
source "$CMD_DIR/build.sh"

rebuild()
{
    clear
    build
    create_info_log "Project rebuild successfully." "REBUILD"
}

rebuild
