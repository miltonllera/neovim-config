-- Load all config files

require('config.options')
require('config.keymaps')
require('config.commands')
require('config.lazy')
require('config.themes')  -- Theme at the end, to prevent overwrite by other plugins
