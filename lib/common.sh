#!/usr/bin/env bash

die() {
    echo "$1" 1>&2 ; exit 1
}

prompt() {
    local question="$1"
    local default="$2"
    local answer

    read -r -p "$question [$default]: " answer
    echo "${answer:-$default}"
}

# FAZER AINDA
# Opções inválidas - geral
# Projeto sem arquivos .c - build
# Erros de compilação - build
# Permissões insuficientes - run

throw_error() {
    erro="$1"

    case $erro in
	1)
		echo "Erro: Diretório inexistente."
		echo "Uso: ./cbuild <projeto> <comando> [opções]"
		;;
	2)
		echo "Erro: Ausência de arquivos-fonte."
		;;
	3)
	    echo "cbuild is a tool for building, running and managing C project."
        echo "use: cbuild <init|build|clean|run|info> [options]" >&2; die
		;;
	4)
		echo "Erro: Diretório não possui arquivos .c"
		;;
	5)
		echo "Erro de Compilação: GCC não instalado."
		;;
	7)
		echo "Erro de Execução: Tentativa de run sem executável disponível."
		;;
	8)
		echo "Erro de Execução: Permissões insuficientes."
		echo "Sugestão: 'chmod +x ${EXEC}'"
		;;
    esac
}
