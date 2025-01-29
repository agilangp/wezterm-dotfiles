local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- check if OS is Windows
local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

-- use config based on OS
if is_windows() then
	config.font = wezterm.font("RobotoMono Nerd Font")
	config.default_prog = { "pwsh.exe", "-NoLogo" }

	-- make terminal to spawn on the center of the screen on windows
	wezterm.on("gui-startup", function(cmd)
		local screen = wezterm.gui.screens().active
		local ratio = 0.7 -- Adjust this ratio to set the size of the window
		local width, height = screen.width * ratio, screen.height * ratio
		local tab, pane, window = wezterm.mux.spawn_window({
			position = {
				x = (screen.width - width) / 2,
				y = (screen.height - height) / 2,
				origin = "ActiveScreen",
			},
		})
		window:gui_window():set_inner_size(width, height)
	end)
else
	config.font = wezterm.font("RobotoMonoNerd Font")
	config.enable_wayland = false
end

config.font_size = 10
config.color_scheme = "OneDark (base16)"
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

return config
