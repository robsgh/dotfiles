-- Webcam overlay for screen recording.
local match = { title = "WebcamOverlay" }
hl.window_rule({ match = match, float = true })
hl.window_rule({ match = match, pin = true })
hl.window_rule({ match = match, no_initial_focus = true })
hl.window_rule({ match = match, no_dim = true })
hl.window_rule({ match = match, move = "(monitor_w-window_w-40) (monitor_h-window_h-40)" })
