local telescope = require('telescope')
local builtin = require('telescope.builtin')
telescope.setup({
    defaults = {
        path_display = { "smart" },
    },
    pickers= {
        git_files = {
            show_untracked = true,
            hidden = true,
            previewer = false,
            layout_config = {
                width = 0.9,
                height = 0.9,
                prompt_position = "bottom",
            },
        },
        find_files = {
            hidden = true,
            previewer = false,
            layout_config = {
                width = 0.9,
                height = 0.9,
                prompt_position = "bottom",
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
})
telescope.load_extension('fzf')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
