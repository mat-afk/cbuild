#!/bin/bash

CMD_DIR="cmd"

case "$1" in
    build)
        bash "${CMD_DIR}/build.sh"
        ;;
    run)
        bash "${CMD_DIR}/run.sh"
        ;;
    clean)
        bash "${CMD_DIR}/clean.sh"
        ;;
    rebuild)
        bash "${CMD_DIR}/rebuild.sh"
        ;;
    info)
        bash "${CMD_DIR}/info.sh"
        ;;
esac
