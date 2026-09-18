#!/usr/bin/env bash

verbose() {
    local message="$1"

	if [[ $VERB == true ]]; then
		echo "$message"
	fi
}

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

throw_error() {
    error="$1"

    case $error in
    	missing_directory)
            dir="$2"
    		echo "error: directory '$dir' does not exist."
    		;;
    	missing_conf)
			die "error: this is not a cbuild project (run 'cbuild init')."
    		;;
		invalid_cc)
			die "'$cc' is not a recognized C compiler."
    		;;
    	missing_cc)
            local cc="$2"
    		die "error: '$cc' not installed."
    		;;
    	missing_binaries)
    		die "error: missing binaries (run 'cbuild build' to compile project)."
    		;;
    	missing_files)
    		die "error: no .c files."
			;;
    	permission_denied)
			die "execution error: permission denied (run 'chmod +x ${BIN}' to grant permission)."
    		;;
    esac
}

check_cc_and_throw() {
    local cc="$1"
    check_cc "$cc" || throw_error missing_cc "$cc"
}
