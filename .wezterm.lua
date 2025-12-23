local wezterm = require("wezterm")
local config = wezterm.config_builder()

local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[2]

config.color_scheme = "Kanagawa (Gogh)"
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"

local act = wezterm.action
config.keys = {
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
	{ key = "t", mods = "CTRL", action = act.EmitEvent("toggle-tabbar") },
}

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

return config
