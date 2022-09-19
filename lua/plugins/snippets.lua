-- LuaSnip
local status, luasnipLoaders = pcall(require, "luasnip.loaders.from_vscode")
if (not status) then return end

luasnipLoaders.lazy_load()
require('luasnip').filetype_extend("python", {'pytorch'})
