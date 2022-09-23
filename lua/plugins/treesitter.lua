-- Treesitter configuration
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

--require('nvim-treesitter.configs').setup({
	--highlight = { enable = true, additional_vim_regex_highlighting = false},
  -- We must manually specify which parsers to install
	--ensure_installed = {
    --"bash",
    --"c",
    --"cpp",
    --"cuda",
		--"json",
    --"julia",
		--"lua",
    --"python",
    --"yaml",
    --"typescript", 
    --"javascript", 
    --"html", 
    --"css", 
    --"scss", 
    --"c_sharp", 
    --"tsx" 
	--},
--})

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "typescript", 
    "javascript", 
    "scss", 
    "c_sharp", 
    "tsx",
  },
  autotag = {
    enable = true,
  },
}

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }