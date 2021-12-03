local fn = vim.fn
local common_on_attach = require('lsp.utils').common_on_attach

local system_name
if fn.has('mac') == 1 then
  system_name = 'macOS'
elseif fn.has('unix') == 1 then
  system_name = 'Linux'
elseif fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsuported system for sumneko')
end


local sumneko_root_path = fn.stdpath('data')..'/lsp_servers/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  -- Does not have a default cmd, so we need to manually provide it
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("",true),
      },
      telemetry ={
        enable = false,
      },
    },
  },
  on_attach = common_on_attach,
}
