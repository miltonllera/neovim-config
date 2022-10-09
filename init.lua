
-- Load all config files
require('options')
require('keymaps')
require('commands')
require('plugins')
require('themes')  -- Theme at the end, to prevent overwrite by other plugins

-- compile the lua code to bitecode so neovim start up faster
pcall(require, 'impatient')
