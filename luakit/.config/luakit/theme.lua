----------------------------
-- Solarized luakit theme --
----------------------------

-- Adapted from Andre Hilsendeger's theme:
-- https://github.com/ahilsend/dotfiles/blob/master/.config/luakit/theme.lua

-- Solarized colors
local colors = {
    yellow  = "#b58900",
    orange  = "#cb4b16",
    red     = "#dc322f",
    magenta = "#d33682",
    violet  = "#6c71c4",
    blue    = "#268bd2",
    cyan    = "#2aa198",
    green   = "#859900",

    base03  = "#002b36",
    base02  = "#073642",
    base01  = "#586e75",
    base00  = "#657b83",
    base0   = "#839496",
    base1   = "#93a1a1",
    base2   = "#eee8d5",
    base3   = "#fdf6e3",
}

local theme = {}

-- Default settings
theme.font = "12px monospace"
theme.fg   = colors.base0
theme.bg   = colors.base03

-- Genaral colours
theme.success_fg = colors.green
theme.loaded_fg  = colors.yellow
theme.error_fg = colors.base3
theme.error_bg = colors.red

-- Warning colours
theme.warning_fg = colors.base3
theme.warning_bg = colors.red

-- Notification colours
theme.notif_fg = colors.yellow
theme.notif_bg = colors.base2

-- Menu colours
theme.menu_fg                   = colors.base0
theme.menu_bg                   = colors.base03
theme.menu_selected_fg          = colors.base1
theme.menu_selected_bg          = colors.base01
theme.menu_title_bg             = colors.base03
theme.menu_primary_title_fg     = colors.base1
theme.menu_secondary_title_fg   = colors.base2

theme.menu_disabled_fg = "#999" -- TODO
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#060" -- TODO
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = colors.base3
theme.sbar_bg         = colors.base01

-- Downloadbar specific
theme.dbar_fg         = colors.base0
theme.dbar_bg         = colors.base03
theme.dbar_error_fg   = colors.red

-- Input bar specific
theme.ibar_fg           = colors.base0
theme.ibar_bg           = colors.base03

-- Tab label
theme.tab_fg            = colors.base0
theme.tab_bg            = colors.base03
theme.tab_hover_bg      = colors.base00
theme.tab_ntheme        = colors.base3
theme.selected_fg       = colors.base3
theme.selected_bg       = colors.base02
theme.selected_ntheme   = colors.base3
theme.loading_fg        = colors.yellow
theme.loading_bg        = colors.base02

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = colors.green
theme.notrust_fg        = colors.red

-- General colour pairings
theme.ok = { fg = "#000", bg = "#FFF" }
theme.warn = { fg = "#F00", bg = "#FFF" }
theme.error = { fg = "#FFF", bg = "#F00" }

-- FIXME this is very ugly, fix this!
local status, stdout, stderr = luakit.spawn_sync("hostname")
assert(status == 0, "hostname command failed: "..tostring(stderr))
stdout = stdout:gsub("%s", "")

if stdout == "arch-surface" then
    theme.font = "20px monospace"
end

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
