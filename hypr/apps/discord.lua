local match = { class = ".*discord.*" }
hl.window_rule({ match = match, workspace = "2" })
hl.window_rule({ match = match, no_initial_focus = true })
