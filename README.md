# tmux-nowplaying

[![GitHub](https://img.shields.io/github/license/xwjdsh/tmux-nowplaying)](https://opensource.org/licenses/MIT)

Shows now playing media in the status line.

<p align="center">
  <img src="https://github.com/xwjdsh/tmux-nowplaying/raw/main/assets/tmux-nowplaying.gif" alt="tmux-nowplaying">
</p>

## Installation

### Requirements

- macOS
- [nowplaying-cli](https://github.com/kirtan-shah/nowplaying-cli)

### With Tmux Plugin Manager

Add the plugin in `.tmux.conf`:

```
set -g @plugin 'xwjdsh/tmux-nowplaying'
```

Press `prefix + I` to fetch the plugin and source it. Done.

### Manual

Clone the repo somewhere. Add `run-shell` in the end of `.tmux.conf`:

```
run-shell PATH_TO_REPO/tmux-nowplaying.tmux
```

NOTE: this line should be placed after `set-option -g status-right ...`.

Press `prefix + :` and type `source-file ~/.tmux.conf`. Done.

## Usage

Add `#{nowplaying}` somewhere in the right status line:

```
set-option -g status-right "#{nowplaying}"
```

then you will see the current playing media in the status line.

## Customization

The plugin could be customized with:

- `set-option -g @tmux-nowplaying-length 15` - Set the display length in the status line, if exceeded the display will scroll, by default it is 20.
- `set-option -g @tmux-nowplaying-play "▶️"` - Set the play symbol, by default it is "▶".
- `set-option -g @tmux-nowplaying-pause "⏸️"` - Set the pause symbol, by default it is "⏸".

## License

tmux-nowplaying plugin is released under the [MIT License](https://opensource.org/licenses/MIT).
