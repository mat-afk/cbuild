#!/usr/bin/env bash

LOG_FILE="$LOG_DIR/cbuild.log"

LAST_RUN=""
LAST_BUILD=""

create_log() {
    local level="$1"
    shift

    local message="$*"
    local date
    local log_entry

    date="$(date '+%Y-%m-%d %H:%M:%S')"
    log_entry="[$date] [$level] $message"

    sed -i "1i\\$log_entry" "$LOG_FILE"

    echo "$log_entry"
}

create_info_log() {
    LAST_RUN="$(create_log "INFO" "$@")"
}

create_success_log() {
	verbose "$1"
    LAST_RUN="$(create_log "SUCCESS" "$@")"
}

create_build_log() {
	verbose "$1"
    LAST_BUILD="$(create_log "BUILD" "$@")"
}

create_error_log() {
    LAST_RUN="$(create_log "ERROR" "$@")"
}
