local config = require('session_manager.config')

-- don't automatically load up previous session
require('session_manager').setup({
  autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
})
