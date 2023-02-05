local telescope = require('telescope')
local builtin = require('telescope.builtin')
telescope.setup({
    defaults = {
        path_display = { "smart" },
    },
})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

