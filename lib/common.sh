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
    local error="$1"

    case "$error" in
        1)
            local message="Non-existing directory."
            echo "Uso: ./cbuild <projeto> <comando> [opções]"
            create_error_log "$message"
            ;;

        2)
            local message="Source files are missing."
            echo "Erro: Ausência de arquivos-fonte."
            create_error_log "$message"
            ;;

        unknown_command)
            local message="Unknown cbuild command."
            create_error_log "$message"
            die "use: cbuild <init|build|clean|run|info> [options]"
            ;;

        4)
            local message="Directory doesn't have any C files"
            create_error_log "$message"
            ;;

        missing_cc)
            local cc="$2"
            local message="'$cc' is not installed."
            create_error_log "$message"
            die "$message"
            ;;

        missing_binaries)
            local message="Missing binaries (run 'cbuild build' to compile project)"
            create_error_log "$message"
            die "$message"
            ;;

        8)
            local message="Insufficient permissions."
            echo "Erro de Execução: Permissões insuficientes."
            echo "Sugestão: 'chmod +x ${EXEC}'"
            create_error_log "$message"
            ;;

        *)
            local message="Unknown error."
            create_error_log "$message"
            die "$message"
            ;;
    esac
}
check_cc_and_throw() {
    local cc="$1"
    check_cc "$cc" || throw_error missing_cc "$cc"
}
