local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

local statusCompletion, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if (not statusCompletion) then return end

local statusCmp, cmp = pcall(require, "cmp")
if (not statusCmp) then return end


autopairs.setup({check_ts = true})
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))