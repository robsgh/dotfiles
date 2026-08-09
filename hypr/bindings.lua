-- Application bindings.
local terminal = "ghostty --gtk-single-instance=false"
local browser = "rob-launch-browser"
local main_mod = "SUPER"

local function bind(keys, description, dispatcher, flags)
    flags = flags or {}
    flags.description = description
    hl.bind(keys, dispatcher, flags)
end

bind(main_mod .. " + RETURN", "Terminal", hl.dsp.exec_cmd(terminal .. ' --working-directory="$(rob-terminal-cwd)"'))
bind(main_mod .. " + E", "File manager", hl.dsp.exec_cmd('nautilus --new-window "$(rob-terminal-cwd)"'))
bind(main_mod .. " + SHIFT + E", "File manager (default)", hl.dsp.exec_cmd("nautilus --new-window"))
bind(main_mod .. " + O", "Browser", hl.dsp.exec_cmd(browser))
bind(main_mod .. " + SHIFT + O", "Browser (private)", hl.dsp.exec_cmd(browser .. " --private"))
bind(main_mod .. " + SHIFT + T", "Activity", hl.dsp.exec_cmd("rob-launch-tui btop"))

bind(main_mod .. " + Q", "Close window", hl.dsp.window.close())
bind(main_mod .. " + ESCAPE", "System menu", hl.dsp.exec_cmd("rob-system-menu"))
bind(main_mod .. " + ALT + K", "Show key bindings", hl.dsp.exec_cmd("rob-keybindings"))

-- Move focus with Super + vim keys.
bind(main_mod .. " + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
bind(main_mod .. " + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))
bind(main_mod .. " + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
bind(main_mod .. " + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))

hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }), { repeating = true })
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }), { repeating = true })

bind(main_mod .. " + F", "Toggle Window Floating", hl.dsp.window.float())
bind(main_mod .. " + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind("SUPER + SPACE", "Launch apps", hl.dsp.exec_cmd("rob-launcher"))

-- Notifications.
bind("SUPER + COMMA", "Dismiss last notification", hl.dsp.exec_cmd("makoctl dismiss"))
bind("SUPER + SHIFT + COMMA", "Dismiss all notifications", hl.dsp.exec_cmd("makoctl dismiss --all"))
bind("SUPER + CTRL + COMMA", "Toggle silencing notifications", hl.dsp.exec_cmd("rob-toggle-notifications"))
bind("SUPER + ALT + COMMA", "Invoke last notification", hl.dsp.exec_cmd("makoctl invoke"))
bind("SUPER + SHIFT + ALT + COMMA", "Restore last notification", hl.dsp.exec_cmd("makoctl restore"))

-- Toggles.
bind("SUPER + CTRL + I", "Toggle locking on idle", hl.dsp.exec_cmd("rob-toggle-idle"))
bind("SUPER + CTRL + N", "Toggle nightlight", hl.dsp.exec_cmd("rob-toggle-nightlight"))
bind("SUPER + CTRL + Delete", "Toggle laptop display", hl.dsp.exec_cmd("rob-monitor-internal toggle"))
bind("SUPER + CTRL + ALT + Delete", "Toggle laptop display mirroring", hl.dsp.exec_cmd("rob-monitor-internal-mirror toggle"))
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("rob-external-monitors && rob-monitor-internal off"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("rob-monitor-internal on"), { locked = true })

-- Captures.
bind("PRINT", "Screenshot", hl.dsp.exec_cmd("rob-screenshot"))
bind("ALT + PRINT", "Screenrecording", hl.dsp.exec_cmd("rob-screenrecord-menu"))
bind("SUPER + PRINT", "Color picker", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))

-- Control panels.
bind("SUPER + CTRL + A", "Audio controls", hl.dsp.exec_cmd("rob-audio"))
bind("SUPER + CTRL + B", "Bluetooth controls", hl.dsp.exec_cmd("rob-bluetooth"))
bind("SUPER + CTRL + W", "Wifi controls", hl.dsp.exec_cmd("rob-wifi"))
bind("SUPER + CTRL + T", "Activity", hl.dsp.exec_cmd("rob-launch-or-focus-tui btop"))

bind("SUPER + CTRL + L", "Lock system", hl.dsp.exec_cmd("rob-lock"))

-- Copy / paste.
bind("SUPER + C", "Universal copy", hl.dsp.exec_cmd("rob-clipboard-shortcut copy"))
bind("SUPER + V", "Universal paste", hl.dsp.exec_cmd("rob-clipboard-shortcut paste"))
bind("SUPER + X", "Universal cut", hl.dsp.exec_cmd("rob-clipboard-shortcut cut"))
bind("SUPER + CTRL + V", "Clipboard manager", hl.dsp.exec_cmd("rob-launcher -m clipboard"))

-- Laptop multimedia keys (locked = works on lockscreen, repeating = hold to repeat).
bind("XF86AudioRaiseVolume", "Volume up", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 100"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", "Volume down", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
bind("XF86AudioMute", "Mute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true, repeating = true })
bind("XF86AudioMicMute", "Mute microphone", hl.dsp.exec_cmd("rob-mic-mute"), { locked = true, repeating = true })
bind("XF86MonBrightnessUp", "Brightness up", hl.dsp.exec_cmd("rob-brightness +5%"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown", "Brightness down", hl.dsp.exec_cmd("rob-brightness 5%-"), { locked = true, repeating = true })
bind("SHIFT + XF86MonBrightnessUp", "Brightness maximum", hl.dsp.exec_cmd("rob-brightness 100%"), { locked = true, repeating = true })
bind("SHIFT + XF86MonBrightnessDown", "Brightness minimum", hl.dsp.exec_cmd("rob-brightness 1%"), { locked = true, repeating = true })
bind("XF86KbdBrightnessUp", "Keyboard brightness up", hl.dsp.exec_cmd("rob-keyboard-brightness up"), { locked = true, repeating = true })
bind("XF86KbdBrightnessDown", "Keyboard brightness down", hl.dsp.exec_cmd("rob-keyboard-brightness down"), { locked = true, repeating = true })
bind("XF86KbdLightOnOff", "Keyboard backlight cycle", hl.dsp.exec_cmd("rob-keyboard-brightness cycle"), { locked = true })
bind("XF86TouchpadToggle", "Toggle touchpad", hl.dsp.exec_cmd("rob-touchpad"), { locked = true })
bind("XF86TouchpadOn", "Enable touchpad", hl.dsp.exec_cmd("rob-touchpad on"), { locked = true })
bind("XF86TouchpadOff", "Disable touchpad", hl.dsp.exec_cmd("rob-touchpad off"), { locked = true })

-- Precise 1% multimedia adjustments with Alt.
bind("ALT + XF86AudioRaiseVolume", "Volume up precise", hl.dsp.exec_cmd("swayosd-client --output-volume +1"), { locked = true, repeating = true })
bind("ALT + XF86AudioLowerVolume", "Volume down precise", hl.dsp.exec_cmd("swayosd-client --output-volume -1"), { locked = true, repeating = true })
bind("ALT + XF86MonBrightnessUp", "Brightness up precise", hl.dsp.exec_cmd("rob-brightness +1%"), { locked = true, repeating = true })
bind("ALT + XF86MonBrightnessDown", "Brightness down precise", hl.dsp.exec_cmd("rob-brightness 1%-"), { locked = true, repeating = true })

-- Requires playerctl.
bind("XF86AudioNext", "Next track", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { locked = true })
bind("XF86AudioPause", "Pause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
bind("XF86AudioPlay", "Play", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
bind("XF86AudioPrev", "Previous track", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { locked = true })
