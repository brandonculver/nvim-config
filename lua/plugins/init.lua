require "plugins.tsitter"
require "plugins.windline"
require "plugins.telescope"
require "plugins.sign"
require "plugins.commented"
require "plugins.onedark"
--  require "plugins.nord"

--  vim.cmd [[colorscheme nord]]
vim.cmd [[colorscheme onedark]]

require("nvim-lsp-installer").setup {}
require "nvim-web-devicons".setup()
require "nvim-ts-autotag".setup()
require "onedark".load()
