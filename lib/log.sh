#!/usr/bin/env bash

LOG_FILE_NAME="cbuild.log"

LOG_FILE=""
[[ -n "$LOGS_DIR" ]] && LOG_FILE="$LOGS_DIR/$LOG_FILE_NAME"

log() {
    local level="$1"
    local message="$2"
    local command="${SCOPE:-"cbuild"}"

    local date
    local log_entry

    local date="$(date '+%Y-%m-%d %H:%M:%S')"
    local log_entry="[$date] [$command] [$level] $message"

    if [[ -s "$LOG_FILE" ]]; then
        sed -i "1i\\$log_entry" "$LOG_FILE"
    else
        touch "$LOG_FILE"
        echo "$log_entry" > "$LOG_FILE"
    fi

    if [[ $DBG == true && $level == "DEBUG" ]]; then
        echo "DEBUG: $message"
    fi
}

log_info() {
    log INFO "$*"
}

log_warn() {
    log WARN "$*"
}

log_debug() {
    log DEBUG "$*"
}

log_error() {
    log ERROR "$*"
}
