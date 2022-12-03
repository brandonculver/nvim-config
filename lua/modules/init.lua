local function conf(name)
  return require(string.format('modules.config.%s', name))
end

local plugins = {
  { -- Colorschemes
    'olimorris/onedarkpro.nvim',
  },
  { -- Treesiter
    'nvim-treesitter/nvim-treesitter',
    config = conf 'nvim-treesitter',
    requires = {
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  { -- Markdown
    'preservim/vim-markdown',
  },
  { -- Finder
    'nvim-telescope/telescope.nvim',
    config = conf 'telescope',
    requires = { 'nvim-lua/plenary.nvim' },
  },
  { -- File tree
    'kyazdani42/nvim-tree.lua',
    config = conf 'nvim-tree',
  },
  { -- Icons
    'kyazdani42/nvim-web-devicons',
    config = function()
      local nvim_web_devicons = safe_require 'nvim-web-devicons'
      if not nvim_web_devicons then
        return
      end

      nvim_web_devicons.setup {
        override = {
          css = { icon = '', color = '#61afef', name = 'css' },
          html = { icon = '', color = '#DE8C92', name = 'html' },
          jpeg = { icon = ' ', color = '#BD77DC', name = 'jpeg' },
          jpg = { icon = ' ', color = '#BD77DC', name = 'jpg' },
          js = { icon = '', color = '#EBCB8B', name = 'js' },
          mp3 = { icon = '', color = '#C8CCD4', name = 'mp3' },
          mp4 = { icon = '', color = '#C8CCD4', name = 'mp4' },
          out = { icon = '', color = '#C8CCD4', name = 'out' },
          png = { icon = ' ', color = '#BD77DC', name = 'png' },
          toml = { icon = '', color = '#61afef', name = 'toml' },
          ts = { icon = 'ﯤ', color = '#519ABA', name = 'ts' },
          xz = { icon = '', color = '#EBCB8B', name = 'xz' },
          zip = { icon = '', color = '#EBCB8B', name = 'zip' },
          zsh = { icon = '', color = '#428850', name = 'Zsh' },
        },
      }
    end,
  },
  { -- Copilot
    'github/copilot.vim',
    config = function()
      vim.cmd [[imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")]]
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ['*'] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
      }
    end,
  },
  { -- Lsp
    'neovim/nvim-lspconfig',
    config = conf 'lsp',
    requires = {
      'williamboman/nvim-lsp-installer',
      'b0o/schemastore.nvim', -- JSON schema for jsonls
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'RRethy/vim-illuminate',
    },
  },
  { -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    config = conf 'nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim', -- Enables icons on completions
      { -- Snippets
        'L3MON4D3/LuaSnip',
        requires = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
  },
  { -- Git related
    {
      'lewis6991/gitsigns.nvim',
      config = conf 'gitsigns',
      requires = { 'nvim-lua/plenary.nvim' },
    },
    { -- Like magit
      'TimUntersberger/neogit',
      config = function()
        local neogit = safe_require 'neogit'
        if not neogit then
          return
        end

        neogit.setup {
          disable_signs = false,
          disable_context_highlighting = false,
          disable_commit_confirmation = false,
          -- customize displayed signs
          signs = {
            -- { CLOSED, OPENED }
            section = { '>', 'v' },
            item = { '>', 'v' },
            hunk = { '', '' },
          },
          integrations = { diffview = true },
        }
      end,
      requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    },
  },
  { -- Comments
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround', requires = { 'tpope/vim-repeat' } },
  },
  { -- Autopairs
    'windwp/nvim-autopairs',
    config = conf 'nvim-autopairs',
  },
  { -- Bufferline
    'akinsho/nvim-bufferline.lua',
    config = conf 'nvim-bufferline',
  },
  { -- Statusline
    'nvim-lualine/lualine.nvim',
    config = function()
      local lualine = safe_require 'lualine'
      if not lualine then
        return
      end

      lualine.setup {
        options = {
          icons_enabled = true,
          theme = vim.g.colors_name or 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'dashboard', 'NvimTree', 'packer' },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
          lualine_c = { 'filename' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
  { -- Colorizer
    'norcalli/nvim-colorizer.lua',
    config = conf 'nvim-colorizer',
  },
}

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd 'packadd packer.nvim'
end

local packer = safe_require 'packer'
if packer then
  packer.init {
    compile_path = vim.fn.stdpath 'data' .. '/site/plugin/packer_compiled.lua',
    package_root = vim.fn.stdpath 'data' .. '/site/pack',
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end)
end
