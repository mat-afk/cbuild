#!/usr/bin/env bash

LOG_FILE="$LOGS_DIR/cbuild.log"

log() {
    local level="$1"
    local message="$2"
    local command="${SCOPE:-"cbuild"}"

    local date
    local log_entry

    date="$(date '+%Y-%m-%d %H:%M:%S')"
    log_entry="[$date] [$command] [$level] $message"

    if [[ -s "$LOG_FILE" ]]; then
        sed -i "1i\\$log_entry" "$LOG_FILE"
    else
        echo "$log_entry" > "$LOG_FILE"
    fi

    if [[ $DBG == true && $level == "DEBUG" ]]; then
        echo "DEBUG: $message"
    fi
}

log_info() {
    log INFO "$1"
}

log_warn() {
    log WARN "$1"
}

log_debug() {
    log DEBUG "$1"
}

log_error() {
    log ERROR "$1"
}
