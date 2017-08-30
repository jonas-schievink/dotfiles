-- Imports bookmarks from chromium when `require`d. Deletes all existing
-- bookmarks, so use with care!
--
-- Also, this only imports stuff inside the bookmark bar.
--
-- Requires lua-json

local bookmarks = require "bookmarks"
local json = require "json"

if not bookmarks.db then bookmarks.init() end

local path = "/home/jonas/.config/chromium/Default/Bookmarks"
local f = assert(io.open(path))
local content = assert(f:read("*a"))

f:close()

local function rec_import(node, bar)
    -- node either has `url` or `children`
    assert(node.url or node.children)

    if node.url then
        print("Adding"..(bar and " (to bar)" or "").." '"..node.name.."' - '"..node.url.."'")
        bookmarks.add(node.url, {
            title = node.name or "",
            tags = bar and "bar" or "",
            desc = "",
        })
    else
        for _, child in ipairs(node.children) do
            rec_import(child, false)
        end
    end
end

local j = assert(json.decode(content))

local bar = assert(j.roots.bookmark_bar.children)

print("Bookmark database: "..bookmarks.db_path)
print("Clearing bookmarks!")
bookmarks.db:exec("DELETE FROM bookmarks")

for _, v in ipairs(bar) do
    -- these are either bookmarks that should go in the bar, or a subfolder that
    -- shouldn't
    rec_import(v, true)
end
