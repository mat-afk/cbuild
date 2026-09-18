#!/usr/bin/env bash

clean()
{
    local tempfiles=($BUILD_DIR/app.exe $OBJ_DIR/*)

    for i in "${tempfiles[@]}"; do
        if [[ -e $i ]]; then
            echo "Cleaning..."
            rm -v $i
            create_success_log "Project cleaned with success." "CLEAN"
        else
            echo "File already removed"
        fi
    done
}

clean
