#!/bin/bash

CC="clang"

[[ -z "which ${CC}" ]] && echo "GCC is not installed. Exiting..." && exit 1







# Erro: Projeto sem arquivos .c (bash "$CMD_DIR/errors.sh" 3)
# Erro: GCC não instalado.
if !(which gcc &> /dev/null); then
	bash "$CMD_DIR/errors.sh" 4
	exit 1
fi
# Erros de compilação (bash "$CMD_DIR/errors.sh" ?)
