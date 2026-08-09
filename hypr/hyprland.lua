-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/

-- Local shared defaults. Each module has its own error scope, so one broken
-- optional app rule does not prevent the rest of the configuration loading.
require("envs")
require("base-windows")

require("monitors")
require("input")
require("bindings")
require("looknfeel")
require("autostart")
require("tiling")

-- Keep this list explicit: Lua's require() does not expand globs.
require("apps.browser")
require("apps.discord")
require("apps.hyprshot")
require("apps.moonlight")
require("apps.pip")
require("apps.qemu")
require("apps.rvu")
require("apps.signal")
require("apps.steam")
require("apps.system")
require("apps.telegram")
require("apps.terminals")
require("apps.typora")
require("apps.voxel-automation")
require("apps.walker")
require("apps.webcam-overlay")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})
