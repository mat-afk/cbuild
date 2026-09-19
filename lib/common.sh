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
        sources_missing)
            dir="$2"
       		die "error: no source file was found in 'src' directory, skipping."
       		;;
    	missing_directory)
            dir="$2"
    		die "error: directory '$dir' does not exist."
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
    	already_initialized)
            local target_dir="$2"
    		die "error: current directory ($target_dir) is already a cbuild project (found cbuild.conf)"
			;;
    	permission_denied)
			die "error: permission denied (run 'chmod +x ${BIN}' to grant permission)."
    		;;
    esac
}

check_cc_and_throw() {
    local cc="$1"
    check_cc "$cc" || throw_error missing_cc "$cc"
}
