#!/usr/bin/env bash

die() {
    local message="$1"
    echo "$message" 1>&2 ; exit 1
}

prompt() {
    local question="$1"
    local default="$2"
    local answer

    read -r -p "$question [$default]: " answer
    echo "${answer:-$default}"
}

check_cc() {
    local cc="$1"
    command -v "$cc" >/dev/null 2>&1 && return 0 || return 1
}

# FAZER AINDA
# Opções inválidas - geral
# Projeto sem arquivos .c - build
# Erros de compilação - build
# Permissões insuficientes - run

throw_error() {
    error="$1"

    case $error in
    	1)
    		echo "Erro: Diretório inexistente."
    		echo "Uso: ./cbuild <projeto> <comando> [opções]"
    		;;
    	2)
    		echo "Erro: Ausência de arquivos-fonte."
    		;;
    	unknown_command)
    	    echo "cbuild is a tool for building, running and managing C projects."
            die "use: cbuild <init|build|clean|run|info> [options]"
    		;;
    	4)
    		echo "Erro: Diretório não possui arquivos .c"
    		;;
    	missing_cc)
            local cc="$2"
    		die "Error: '$cc' is not installed."
    		;;
    	missing_binaries)
    		die "Error: missing binaries (run 'cbuild build' to compile project)"
    		;;
    	8)
    		echo "Erro de Execução: Permissões insuficientes."
    		echo "Sugestão: 'chmod +x ${EXEC}'"
    		;;
    esac
}

check_cc_and_throw() {
    local cc="$1"
    check_cc "$cc" || throw_error missing_cc "$cc"
}
