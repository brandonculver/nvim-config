local util = require "lspconfig/util"
local lspconfig = require "lspconfig"

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT} --single-quote --arrow-parens 'avoid' --trailing-comma all",
  formatStdin = true
}

--  local eslint_d = {
--  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--  lintStdin = true,
--  lintSource = "eslint_d",
--  lintFormats = {"%f:%l:%c: %m"},
--  lintIgnoreExitCode = true
--  }

local stylelint = {
  lintCommand = "stylelint --stdin --stdin-filename ${INPUT} --formatter compact",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    "%f: line %l, col %c, %tarning - %m",
    "%f: line %l, col %c, %trror - %m"
  },
  formatCommand = "stylelint --fix --stdin --stdin-filename ${INPUT}",
  formatStdin = true
}

local luaFormat = {
  formatCommand = "npx luafmt --indent-count 2 --stdin",
  formatStdin = true
}

local credo = {
  lintCommand = "mix credo suggest --strict --format=flycheck --read-from-stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  rootMarkers = {"mix.exs", "mix.lock"}
}

lspconfig.efm.setup {
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    --  vim.api.nvim_exec(
    --  [[
    --  augroup LspEfmCleanup
    --  autocmd!
    --  autocmd VimLeavePre * silent! :!prettier_d_slim stop
    --  autocmd VimLeavePre * silent! :!eslint_d stop
    --  augroup END
    --  ]],
    --  true
    --  )
  end,
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    codeAction = true
  },
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "vue",
    "lua",
    "elixir",
    "css",
    "scss",
    "html",
    "json"
  },
  settings = {
    rootMarkers = {"package.json", ".git", ".git/"},
    lintDebounce = 300,
    languages = {
      typescript = {prettier},
      javascript = {prettier},
      typescriptreact = {prettier},
      javascriptreact = {prettier, stylelint},
      ["javascript.jsx"] = {prettier},
      lua = {luaFormat},
      html = {prettier},
      css = {prettier, stylelint},
      scss = {prettier, stylelint},
      json = {prettier},
      conf = {prettier}
    }
  }
}
