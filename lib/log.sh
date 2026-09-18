#!/usr/bin/env bash

LOG_DIR="$PROJECT_ROOT/logs"
LOG_FILE="$LOG_DIR/cbuild.log"

mkdir -p "$LOG_DIR"

create_log() {
    local level="$1"
    local message="$2"
    local command="$3"

    local date
    local log_entry

    date="$(date '+%Y-%m-%d %H:%M:%S')"
    log_entry="[$date] [$command] [$level] $message"

    if [[ -s "$LOG_FILE" ]]; then
        sed -i "1i\\$log_entry" "$LOG_FILE"
    else
        echo "$log_entry" > "$LOG_FILE"
    fi

    echo "$log_entry"
}

create_success_log() {
    create_log "SUCCESS" "$1" "$2"

}

create_info_log() {
    create_log "INFO" "$1" "$2"
}

create_error_log() {
    create_log "ERROR" "$1" "$2"
}
