-- Allows the user to add another bar to the browser window, containing

local bookmarks = require "bookmarks"
local msg = require "msg"
local lousy = require "lousy"
local window = require "window"
local theme = lousy.theme.get()

local function applytheme(bar)
    bar.bg = theme.sbar_bg
end

local function buttontheme(box, hover)
    box.bg = hover and theme.tab_hover_bg or theme.sbar_bg
end

-- Creates a bookmark bar button that navigates to `uri` when clicked on.
local function makebutton(w, bookmark)
    local img = widget{ type = "image" }
    img.margin = 3
    if not img:set_favicon_for_uri(bookmark.uri) then
        img:filename("icons/tab-icon-page.png")
    end

    local box = widget{ type = "eventbox" }
    box.child = img
    box.margin = 2
    box.tooltip = (bookmark.title or "").." - "..bookmark.uri
    -- title TEXT NOT NULL BUT FUCK YOU ANYWAY

    box:add_signal("button-press", function(box, modifiers, button)
        local newtab
        if button == 1 then
            newtab = lousy.util.table.hasitem(modifiers, "Control") and true or false
        elseif button == 2 then
            newtab = true
        end
        if newtab == true then
            w:new_tab(bookmark.uri)
        elseif newtab == false then
            w:navigate(bookmark.uri)
        end
    end)

    box:add_signal("mouse-enter", function()
        buttontheme(box, true)
    end)

    box:add_signal("mouse-leave", function()
        buttontheme(box, false)
    end)

    return box
end

return {
    new = function(w)
        local bar = widget{ type = "hbox" }

        bar.homogeneous = false
        bar.spacing = 0

        if not bookmarks.db then bookmarks.init() end
        local rows = bookmarks.db:exec("SELECT uri, title, tags FROM bookmarks")
        for _, row in ipairs(rows) do
            local tags = lousy.util.string.split(row.tags or "")
            if lousy.util.table.hasitem(tags, "bar") then
                bar:pack(makebutton(w, row))
            end
        end

        -- hide bookmark bar when in fullscreen
        w.win:add_signal("property::fullscreen", function(win)
            bar.visible = not win.fullscreen
        end)

        applytheme(bar)
        return bar
    end,
}
