-- Load all config files

require('options')
require('keymaps')
require('commands')
require('plugins')
require('themes')  -- Theme at the end, to prevent overwrite by other plugins
