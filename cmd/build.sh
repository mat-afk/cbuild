#!/bin/bash

CC="clang"

# Erro: GCC não instalado.
[[ -z "which ${CC}" ]] && bash "${CMD_DIR}/errors.sh" 4 && exit 1

# Erro: Projeto sem arquivos .c (bash "${CMD_DIR}/errors.sh" 3)
# Erros de compilação (bash "${CMD_DIR}/errors.sh" ?)

export EXEC="" #colocar o nome do arquivo executável
