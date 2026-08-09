-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Tag all windows for default opacity (apps can remove this tag).
hl.window_rule({
    match = { class = ".*" },
    tag = "+default-opacity",
})

-- Fix some dragging issues with XWayland.
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Apply default opacity after apps have had a chance to opt out.
hl.window_rule({
    match = { tag = "default-opacity" },
    opacity = "1 1",
})
