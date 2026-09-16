#!/usr/bin/env bash

source "$CMD_DIR/clean.sh"
source "$CMD_DIR/build.sh"

rebuild()
{
    clear
    build
}

rebuild
