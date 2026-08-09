-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_options = "", -- e.g. "caps:escape,grp:shifts_toggle"

        repeat_rate = 45,
        repeat_delay = 150,
        follow_mouse = 1,
        numlock_by_default = true,
        sensitivity = -0.8,

        touchpad = {
            scroll_factor = 0.4,
            -- natural_scroll = true,
            -- clickfinger_behavior = true,
        },
    },

    misc = {
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
    },
})
