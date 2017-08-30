-- User configuration file included by rc.lua

-- Excuse^WDisclaimer: I don't understand the current state of the API very
-- well since it's in heavy development and thus badly documented.

-- HTML5 Video Note:
-- Support requires installation of gstreamer plugins which are marked as
-- optional dependencies! On Arch, the required packages are:
--     gst-libav gst-plugins-base gst-plugins-good

-- TODO: Check that downloads work properly
-- TODO: Import chromium bookmarks, add proper tags

require "vertical_tabs"
local modes = require "modes"
local window = require "window"
local msg = require "msg"
local newtab_chrome = require "newtab_chrome"
local editor = require "editor"
local settings = require "settings"
local bookmark_bar = require "bookmark_bar"
local webview = require "webview"

editor.editor_cmd = "termite -e 'nvim {file} +{line}'" -- FIXME untested

settings.window.search_engines = {
    aur  = "https://aur.archlinux.org/packages.php?O=0&K=%s&do_Search=Go",
    arch = "https://wiki.archlinux.org/index.php/Special:Search?fulltext=Search&search=%s",
    gh   = "https://github.com/search?q=%s",
    wiki = "https://en.wikipedia.org/wiki/Special:Search?search=%s",
    yt   = "https://www.youtube.com/results?search_query=%s",
    ebay = "https://www.ebay.de/sch/i.html?&_nkw=%s",
    ama  = "https://www.amazon.de/s/?field-keywords=%s",

    default = "https://google.com/search?q=%s",
}

modes.add_binds("normal", {
    { "<Control-Shift-T>", "Reopen recently closed tab.", function(w)
        w:undo_close_tab(-1)
    end },

    -- "Classic" history navigation:
    -- mod1 = alt
    { "<Mod1-Left>", "Go back.", function(w) w:back(1) end },
    { "<Mod1-Right>", "Go forward.", function(w) w:forward(1) end },
    { "<Mouse8>", "Go back.", function(w) w:back(1) end },
    { "<Mouse9>", "Go forward.", function(w) w:forward(1) end },

    -- make Ctrl+C work in normal mode instead of just in insert
    { "<Control-c>", "Copy selected text.", function()
        luakit.selection.clipboard = luakit.selection.primary
    end },

    -- emulate Ctrl+F to search
    { "<Control-f>", "Search.", function (w) w:start_search("/") end },
    { "<Escape>", "Clear search highlights.", function (w) w:clear_search() end },
    { "<Return>", "Next match.", function (w, m)
        w:search(nil, true)
    end },

    { "v", "Toggle tablist visibility.", function(w)
        w.tablist.visible = not w.tablist.visible
    end },

    { "<F5>", "Reload current page.", function(w) w:reload() end },
})

window.add_signal("build", function(w)
    -- save the session automatically
    -- 1. when the window is closed
    w.win:add_signal("can-close", function()
        w:save_session()
        msg.info("session saved, closing!")
    end)
    -- 2. regularly on a timer
    -- FIXME this could be improved by only running when tabs are opened/closed
    local t = timer{ interval = 60*1000 }
    t:add_signal("timeout", function()
        w:save_session()
        msg.info("session autosaved")
    end)
    t:start()

    -- w.layout: w.tablist.widget w.menu_tabs w.bar_layout

    -- add bookmark bar and reorder bars
    local bookmarks = bookmark_bar.new(w)
    w.layout:pack(bookmarks)
    w.layout:reorder(w.bar_layout, 0)
    w.layout:reorder(bookmarks, 1)

    -- move completions to the top
    -- FIXME: they still appear after the bookmark bar because they're part of
    -- the menu_tabs overlay widget
    w.menu_tabs:pack(w.menu.widget, { halign = "fill", valign = "start" })
end)

-- redirect "new tab" page to bookmarks
newtab_chrome.new_tab_src = [[<meta http-equiv="refresh" content="0;luakit://bookmarks">]]

-- these are just gsub patterns
local redirections = {
    -- redirect direct-links to imgur files to their "real" page
    -- works around gifs being fucking stupid and gifv becoming blank upon
    -- loading
    ["^https://i%.imgur%.com/([^.]+).*$"] = "https://imgur.com/%1",
}

webview.add_signal("init", function(view)
    view:add_signal("navigation-request", function(view, uri)
        local old_uri, n = uri, nil
        for k, v in pairs(redirections) do
            uri, n = uri:gsub(k, v)
            if n ~= 0 then
                msg.info("replaced uri '"..old_uri.."' with '"..uri.."'")
                view.uri = uri
                return false
            end
        end
    end)
end)

-- aptly named debugging utilities
-- for some reason, `:lua print("AAAAH")` does nothing.
-- maybe they don't want anyone to hear our screams...
ugh = {
    dumptable = function(tbl)
        for k,v in pairs(tbl) do
            msg.info(tostring(k)..": "..tostring(v))
        end
    end,
}
