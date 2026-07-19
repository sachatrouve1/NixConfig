local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Load colors from pywal
config.color_scheme = wezterm.color_scheme_from_file '~/.cache/wal/colors-kitty.conf'

-- Font configuration
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10.0

-- Window padding
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- Background opacity
config.window_background_opacity = 0.70

-- Disable audio bell
config.audible_bell = 'Disabled'

-- Tab bar at bottom
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Window frame styling
config.window_decorations = 'TITLE | RESIZE'

-- Key bindings
config.keys = {
  -- Open new tab in current directory
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- Close current tab
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentTab { confirm = false },
  },
}

return config
