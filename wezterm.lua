-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.check_for_updates = false
config.font_size = 14.5
config.font = wezterm.font 'Hack Nerd Font'
-- config.font = wezterm.font('Hack Nerd Font', { italic = true })

config.keys = {
  -- [PaneSelect](https://wezfurlong.org/wezterm/config/lua/keyassignment/PaneSelect.html)
  -- activate pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
  {
    key = '8',
    mods = 'CTRL',
    action = wezterm.action.PaneSelect
  }
}

-- and finally, return the configuration to wezterm
return config

