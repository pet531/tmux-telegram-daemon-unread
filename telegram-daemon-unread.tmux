#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/shared.sh"
source "$CURRENT_DIR/scripts/variables.sh"

telegram_daemon_unread="#($CURRENT_DIR/scripts/telegram_daemon_unread.sh)"
telegram_daemon_unread_string="\#{telegram_d_unread}"

do_interpolation() {
	local string=$1
	local interpolated=${string/$telegram_daemon_unread_string/$telegram_daemon_unread}
	echo "$interpolated"
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
