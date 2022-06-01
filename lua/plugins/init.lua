require "plugins.tsitter"
require "plugins.windline"
require "plugins.telescope"
require "plugins.sign"
require "plugins.commented"
require "plugins.coq"
require "plugins.onedark"
--  require "plugins.nord"

--  vim.cmd [[colorscheme nord]]
vim.cmd [[colorscheme onedark]]

require "nvim-web-devicons".setup()
require "nvim-ts-autotag".setup()
require "onedark".load()

require "lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
            }
        }
    }
}
