#!/bin/bash

CBUILD_ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "$CBUILD_ROOT"
BASHRC="$HOME/.bashrc"

echo "Instalando CBuild em $CBUILD_ROOT"

if ! grep -qF "$CBUILD_ROOT" "$BASHRC"; then
    echo "export PATH=\"\$PATH:$CBUILD_ROOT\"" >> "$BASHRC"
    echo "PATH atualizado no $BASHRC"
else
    echo "CBuild já está no PATH"
fi

export PATH="$PATH:$CBUILD_ROOT"

echo "Instalação concluída!"
