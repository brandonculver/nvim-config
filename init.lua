-- require 'core.utils'
-- require 'core.options'
-- require 'core.keymaps'
-- require 'core.autocmd'
-- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'

function P(cmd)
  print(vim.inspect(cmd))
end

function _G.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return ok
  end
  return result
end

require 'modules'

local o = vim.opt
-- Appearance
o.cmdheight = 1
o.colorcolumn = '80'
o.cursorline = true
-- o.foldmethod = 'marker'
o.number = true
o.relativenumber = true
o.ruler = false -- My statusline take care of that
o.showmode = false
o.signcolumn = 'yes'
o.termguicolors = true
o.wrap = false

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false
-- o.autoread = true -- Automatically read a file when it has been changed from outside vim

-- Completion
o.completeopt = 'menuone,noselect'
o.pumblend = 10 -- Popup menu transparency
o.pumheight = 8 -- Popup menu height

-- General
o.clipboard = 'unnamedplus'
o.hidden = true
o.joinspaces = false
o.mouse = 'a'
o.scrolloff = 8
o.sidescrolloff = 8
o.splitbelow = true
o.splitright = true
o.timeoutlen = 200
o.updatetime = 100
o.virtualedit = 'block'
o.iskeyword = o.iskeyword + '-'

-- -- Listchars
-- vim.opt.list = true
-- vim.opt.listchars:append 'eol:↴'
-- vim.opt.listchars:append 'space:⋅'

-- Performance
o.lazyredraw = true

-- Search
o.inccommand = 'nosplit' -- show substitutions incrementally
o.ignorecase = true
o.smartcase = true
o.wildignore = { '.git/*', 'node_modules/*' }
o.wildignorecase = true

-- Tabs
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Shortmess
o.shortmess = o.shortmess
    + {
      A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
      I = true, -- don't give the intro message when starting Vim |:intro|.
      W = true, -- don't give "written" or "[w]" when writing a file
      c = true, -- don't give |ins-completion-menu| messages
      m = true, -- use "[+]" instead of "[Modified]"
    }

-- Format options
o.formatoptions = o.formatoptions
    + {
      c = false,
      o = false, -- O and o, don't continue comments
      r = true, -- Pressing Enter will continue comments
    }

-- Remove builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1


local map = function(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or { noremap = true, silent = true })
end

vim.g.mapleader = ' '
map('n', '<leader>', '<Nop>')
map('x', '<leader>', '<Nop>')

-- Normal
map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', '<CR>', '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map('n', 'x', '"_x')
map('n', 'X', '"_X')
map('n', '<C-s>', '<cmd>w<CR>')
map('n', '<F9>', '<cmd>lua require"core.compiler".compile_and_run()<CR>')
-- stylua: ignore
-- Copy relative filepath eg: from nvim folder this would look like: "lua/core/keymaps.lua" copied to clipboard
map('n', '<space>fp',
  '<cmd>let @*=fnamemodify(expand("%"), ":~:.") | echo( \'"\' . (fnamemodify(expand("%"), ":~:.")) . \'" copied to clipboard\')<CR>')
-- Buffers
map('i', 'jj', '<esc>')
map('n', ',d', '<cmd>bp<CR>')
map('n', ',f', '<cmd>bn<CR>')
map('n', ',c', '<cmd>bd<CR>')
-- Window
map('n', '<C-h>', '<cmd>wincmd h<CR>')
map('n', '<C-j>', '<cmd>wincmd j<CR>')
map('n', '<C-k>', '<cmd>wincmd k<CR>')
map('n', '<C-l>', '<cmd>wincmd l<CR>')
map('n', '<Up>', '<cmd>wincmd -<CR>')
map('n', '<Down>', '<cmd>wincmd +<CR>')
map('n', '<Left>', '<cmd>wincmd <<CR>')
map('n', '<Right>', '<cmd>wincmd ><CR>')
map('n', '<space>=', '<cmd>wincmd =<CR>')

-- Insert
map('i', '<C-c>', '<Esc>')
map('i', '<S-CR>', '<Esc>o')
map('i', '<C-CR>', '<Esc>O')
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
-- map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })

-- Errors
map('n', ',e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', ',w', '<cmd>Telescope diagnostics<CR>')

-- Format
map('n', ',p', '<cmd>lua vim.lsp.buf.formatting()<CR>')


-- Visual
map('x', '<', '<gv')
map('x', '>', '>gv')
map('x', 'K', ":move '<-2<CR>gv-gv")
map('x', 'J', ":move '>+1<CR>gv-gv")

-- Terminal
map('t', '<C-w>h', '<cmd>wincmd h<CR>')
map('t', '<C-w>j', '<cmd>wincmd j<CR>')
map('t', '<C-w>k', '<cmd>wincmd k<CR>')
map('t', '<C-w>l', '<cmd>wincmd l<CR>')
map('t', '<C-w><C-h>', '<cmd>wincmd h<CR>')
map('t', '<C-w><C-j>', '<cmd>wincmd j<CR>')
map('t', '<C-w><C-k>', '<cmd>wincmd k<CR>')
map('t', '<C-w><C-l>', '<cmd>wincmd l<CR>')

-- Command
map('c', '<C-a>', '<Home>', { silent = false })
map('c', '<C-e>', '<End>', { silent = false })
map('c', '<C-h>', '<Left>', { silent = false })
map('c', '<C-j>', '<Down>', { silent = false })
map('c', '<C-k>', '<Up>', { silent = false })
map('c', '<C-l>', '<Right>', { silent = false })
map('c', '<C-d>', '<Del>', { silent = false })
map('c', '<C-f>', '<C-R>=expand("%:p")<CR>', { silent = false })

-- Git
map('n', '<space>gs', '<cmd>Neogit<CR>')
-- Telescope
map('n', '<C-p>', '<cmd>lua require"telescope.builtin".find_files()<CR>')

map('n', '<space>fb', '<cmd>Telescope buffers theme=get_dropdown<CR>')
map('n', '<space>fh', '<cmd>lua require"telescope.builtin".help_tags()<CR>')
map('n', '<space>fo', '<cmd>lua require"telescope.builtin".oldfiles()<CR>')
map('n', '<space>fw', '<cmd>lua require"telescope.builtin".live_grep()<CR>')
map('n', '<space>fd', '<cmd>lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })<CR>')
-- Tree
map('n', 't', '<cmd>NvimTreeToggle<CR>')
-- Vim surround ( noremap need to be false to work)
map('n', 'ds', '<Plug>Dsurround', { noremap = false })
map('n', 'cs', '<Plug>Csurround', { noremap = false })
map('n', 'cS', '<Plug>CSurround', { noremap = false })
map('n', 's', '<Plug>Ysurround', { noremap = false })
map('n', 'S', '<Plug>YSurround', { noremap = false })
map('n', 'ss', '<Plug>Yssurround', { noremap = false })
map('n', 'SS', '<Plug>YSsurround', { noremap = false })
map('x', 's', '<Plug>VSurround', { noremap = false })
map('x', 'S', '<Plug>VgSurround', { noremap = false })
-- Git signs
map('n', ']g', '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
map('n', '[g', '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })
-- map('n', '', 'Gitsigns blame_line')

vim.cmd [[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]]

vim.cmd [[
    augroup ftplugin
      au!
      au BufWinEnter * set formatoptions-=cro
      au FileType man setl laststatus=0 noruler
      au FileType markdown setl wrap linebreak conceallevel=2
      au FileType vim,html,css,json,javascript,javascriptreact,typescript,typescriptreact,lua,sh,zsh setl sw=2
      au TermOpen term://* setl nornu nonu nocul so=0 scl=no
    augroup END

    augroup highlight_yank
      au!
      au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
    augroup END
]]

vim.cmd 'silent! colorscheme onedarkpro'
