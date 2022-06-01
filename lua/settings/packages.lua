local exec = vim.api.nvim_command
local fn, cmd = vim.fn, vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

cmd [["packadd packer.nvim"]]

cmd "au BufWritePost packages.lua PackerCompile"

local init = {
  -- Packer can manage itself as an optional plugin
  "wbthomason/packer.nvim",
}

local lsp = {
  -- "glepnir/lspsaga.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
  -- "williamboman/nvim-lsp-installer",
  --  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "JoosepAlviste/nvim-ts-context-commentstring",
  -- "tsuyoshicho/vim-efm-langserver-settings", -- auto config efm lsp
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
  "nvim-telescope/telescope-media-files.nvim",

  {'ms-jpq/coq_nvim', branch = "coq"},
  {'ms-jpq/coq.artifacts', branch = "artifacts"},
  {'ms-jpq/coq.thirdparty', branch = "3p"}

}

-- local cmp = {
--   "hrsh7th/nvim-cmp",
--   "hrsh7th/cmp-buffer",
--   "hrsh7th/cmp-nvim-lua",
--   "hrsh7th/cmp-nvim-lsp",
--   "hrsh7th/cmp-path",
--   "hrsh7th/cmp-vsnip",
--   "hrsh7th/vim-vsnip",
--   "hrsh7th/cmp-cmdline",
  --  {"tzachar/cmp-fuzzy-buffer", requires = {"hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim"}}
--jjj}

local git = {
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "rhysd/conflict-marker.vim", -- Highlight conflict markers.[x and ]x, ct for themselves, co for ourselves, cn for none and cb
  "lewis6991/gitsigns.nvim"
  --  "f-person/git-blame.nvim"
}

local misk = {
  --  "editorconfig/editorconfig-vim",
  "winston0410/commented.nvim",
  --  "winston0410/mark-radar.nvim", -- highlight marks by `
  --  "unblevable/quick-scope",
  -- "oberblastmeister/rooter.nvim", -- root dir switcher
  "AndrewRadev/splitjoin.vim", -- allows to split one liner to multi lines
  "mbbill/undotree", -- undo tree
  "machakann/vim-sandwich", -- Change surrounding arks
  -- "metakirby5/codi.vim", --Repl
  --  "voldikss/vim-floaterm",
  "windwp/nvim-ts-autotag", -- Auto change html tags
  --  {"rrethy/vim-hexokinase", run = "make hexokinase"}, -- requires golang installed
  --  "rmagatti/alternate-toggler", --toggling alternate "boolean" values.
  "andymass/vim-matchup",
  -- "rrethy/vim-illuminate", -- highlight matching words when cursor on it
  -- "windwp/nvim-spectre" -- search panel
  -- "glepnir/indent-guides.nvim"
  -- "p00f/nvim-ts-rainbow"
  -- "mattn/emmet-vim",
  -- "justinmk/vim-sneak",
  -- "andweeb/presence.nvim" -- discord
  -- "Pocco81/AbbrevMan.nvim", -- dictionaries
  -- "whatyouhide/vim-lengthmatters",
}

local fzf = {
  {"junegunn/fzf", run = "./install --all"}, -- Fuzzy Searcher
  "junegunn/fzf.vim"
  -- "gfanto/fzf-lsp.nvim"
}

--  local test = {
--  "janko/vim-test",
--  "rcarriga/vim-ultest" -- pretty test output
--  }

--  local langs = {"vieira/vim-javascript", "mxw/vim-jsx"}

local snippets = {
  --  "hollowtree/vscode-vue-snippets",
  --  "dsznajder/vscode-es7-javascript-react-snippets",
  "rafamadriz/friendly-snippets"
}

local themes = {
  --  "sainnhe/gruvbox-material",
  -- "windwp/wind-colors"
  "arcticicestudio/nord-vim"
}

local ui = {
  -- "noib3/cokeline.nvim",
  "beauwilliams/focus.nvim",
  -- "mhinz/vim-startify", -- start screen
  "kyazdani42/nvim-web-devicons",
  --  "akinsho/nvim-bufferline.lua",
  --"kyazdani42/nvim-tree.lua",
  'ms-jpq/chadtree',
  --  "folke/lsp-trouble.nvim",
  --  "https://gitlab.com/yorickpeterse/nvim-window.git",
  "windwp/windline.nvim"
  --  "folke/which-key.nvim",
}

local packer = require("packer")
packer.init {
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  git = {
    clone_timeout = 350
  },
  display = {
    title = "Packer",
    done_sym = "",
    error_syn = "×",
    keybindings = {
      toggle_info = "o"
    }
  }
}

packer.startup {
  {
    init,
    fzf,
    lsp,
    git,
    misk,
    snippets,
    themes,
    ui
    --  langs,
    --  test
  },
  config = {
    display = {
      open_fn = require "packer.util".float
    }
  }
}
if packer_bootstrap then
  require('packer').sync()
end

