#!/bin/bash

CBUILD_ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "$CBUILD_ROOT"
BASHRC="$HOME/.bashrc"

echo "Installing cbuild in $CBUILD_ROOT"

if ! grep -qF "$CBUILD_ROOT" "$BASHRC"; then
    echo "export PATH=\"\$PATH:$CBUILD_ROOT\"" >> "$BASHRC"
    echo "PATH updated in $BASHRC"
else
    echo "cbuild is already in PATH. Enjoy :)"
fi

export PATH="$PATH:$CBUILD_ROOT"

echo "Installation completed!"
