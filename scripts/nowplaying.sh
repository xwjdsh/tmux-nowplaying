#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

get_nowplaying_info() {
	nowplaying-cli get $1
}

scroll_string() {
	local str=$1
	local length=$(get_tmux_option "@tmux-nowplaying-length" 15)
	local result
	if ((${#str} > length)); then
		local index=$(get_tmux_option "@nowplaying-scroll-start" 0)
		spaces_count=2
		spaces=$(printf "%-${spaces_count}s" "")
		if ((index >= ${#str} + spaces_count)); then
			index=0
		fi
		if ((index + length >= ${#str})); then
			str="${str}${spaces}${str}"
		fi

		result="${str:index:length}"

		index=$((index + 1))
		$(set_tmux_option "@nowplaying-scroll-start" "$index")
	else
		result="${str:0:length}"
	fi

	echo "$result"
}

get_nowplaying_text() {
	local title=$1
	local artist=$2
	local result
	if [ "$title" != "null" ] || [ "$artist" != "null" ]; then
		result="$title"
		if [ -n "$artist" ]; then
			result="$result - $artist"
		fi
	fi
	echo "$result"
}

get_nowplaying_state_symbol() {
	local playbackRate=$1
	local result
	if [[ "$playbackRate" == "1" ]]; then
		result=$(get_tmux_option "@tmux-nowplaying-play" "▶")
	else
		result=$(get_tmux_option "@tmux-nowplaying-pause" "⏸")
	fi
	echo "$result"
}

main() {
	local title=$(get_nowplaying_info "title")
	local artist=$(get_nowplaying_info "artist")
	local playbackRate=$(get_nowplaying_info "playbackRate")

	local old_result=$(get_tmux_option "@nowplaying-previous-result" "")
	local result=$(get_nowplaying_text "$title" "$artist")
	if [ "$result" != "$old_result" ]; then
		$(set_tmux_option "@nowplaying-scroll-start" 0)
		$(set_tmux_option "@nowplaying-previous-result" "$result")
	fi

	if [ "$result" == "" ]; then
		echo ""
		return
	fi

	local state_symbol=$(get_nowplaying_state_symbol "$playbackRate")
	echo -n "$state_symbol $(scroll_string "$result")"
}

main
