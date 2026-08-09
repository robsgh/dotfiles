local function bind(keys, description, dispatcher, flags)
    flags = flags or {}
    flags.description = description
    hl.bind(keys, dispatcher, flags)
end

-- Workspace number keys use hardware keycodes, preserving the original layout-independent behavior.
for workspace = 1, 10 do
    local keycode = workspace == 10 and 19 or workspace + 9
    local key = "code:" .. keycode

    bind("SUPER + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = workspace }))
    bind("SUPER + SHIFT + " .. key, "Move window to workspace " .. workspace,
        hl.dsp.window.move({ workspace = workspace, follow = true }))
    bind("SUPER + SHIFT + ALT + " .. key, "Move window silently to workspace " .. workspace,
        hl.dsp.window.move({ workspace = workspace, follow = false }))
end

-- Cycle workspaces.
bind("SUPER + TAB", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
bind("SUPER + SHIFT + TAB", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))
bind("SUPER + CTRL + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))

-- Swap active window with its neighbor.
bind("SUPER + SHIFT + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
bind("SUPER + SHIFT + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
bind("SUPER + SHIFT + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
bind("SUPER + SHIFT + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Cycle applications on the active workspace, then reveal the selected window.
bind("ALT + TAB", "Focus on next window", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
bind("ALT + SHIFT + TAB", "Focus on previous window", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Resize active window.
bind("SUPER + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
bind("SUPER + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
bind("SUPER + SHIFT + code:20", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
bind("SUPER + SHIFT + code:21", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

-- Move/resize windows with Super + LMB/RMB and dragging.
bind("SUPER + mouse:272", "Move window", hl.dsp.window.drag(), { mouse = true })
bind("SUPER + mouse:273", "Resize window", hl.dsp.window.resize(), { mouse = true })

-- Cycle monitor scaling.
bind("SUPER + code:61", "Cycle monitor scaling", hl.dsp.exec_cmd("rob-monitor-scale-cycle"))
bind("SUPER + ALT + code:61", "Cycle monitor scaling backwards", hl.dsp.exec_cmd("rob-monitor-scale-cycle --reverse"))
