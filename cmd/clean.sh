#!/usr/bin/env bash

clean()
{
    if [[ -f "$BUILD_DIR/app.exe" || -n "$(ls -A "$OBJ_DIR")" ]] then
        echo "Cleaning..."
        rm -v $BUILD_DIR/app.exe $OBJ_DIR/*
    else
        echo "Cleared"
    fi
}

clean