-- Browser types.
hl.window_rule({
    match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser|[mM]icrosoft-edge|Vivaldi-stable|helium)" },
    tag = "+chromium-based-browser",
})
hl.window_rule({
    match = { class = "([fF]irefox|zen|librewolf)" },
    tag = "+firefox-based-browser",
})
hl.window_rule({ match = { tag = "chromium-based-browser" }, tag = "-default-opacity" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, tag = "-default-opacity" })

-- Video apps: remove the browser tag so opacity is not applied.
local video_apps = "(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)"
hl.window_rule({ match = { class = video_apps }, tag = "-chromium-based-browser" })
hl.window_rule({ match = { class = video_apps }, tag = "-default-opacity" })

-- Force Chromium-based browsers into a tile to deal with --app behavior.
hl.window_rule({ match = { tag = "chromium-based-browser" }, float = false })

hl.window_rule({ match = { tag = "chromium-based-browser" }, opacity = "1.0 0.97" })
hl.window_rule({ match = { tag = "firefox-based-browser" }, opacity = "1.0 0.97" })

-- Hide the screen-sharing notification bar.
hl.window_rule({ match = { title = ".*is sharing.*" }, workspace = "special silent" })
