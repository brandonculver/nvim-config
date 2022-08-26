return function()
  local treesitter = safe_require 'nvim-treesitter.configs'
  if not treesitter then
    return
  end

  treesitter.setup {
    ensure_installed = 'all',
    highlight = {
      enable = true, -- false will disable the whole extension
      -- disable = { 'json' }, -- list of language that will be disabled
    },
    indent = { enable = true },
    autopairs = { enable = true },
    rainbow = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
  }
end
