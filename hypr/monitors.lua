-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.env("GDK_SCALE", "1")

hl.monitor({
    output = "DP-1",
    mode = "2560x1440@164.96",
    position = "0x0",
    scale = 1,
    vrr = 0,
})

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@144",
    position = "auto-left",
    scale = "auto",
    transform = 1,
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- Examples:
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.666667 })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })
