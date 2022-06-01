require("formatter").setup {
    filetype = {
        lua = {
            require("formatter.filetypes.lua").luafmt
        },
        javascript = {
            require("formatter.filetypes.javascript").prettiereslint
        },
        javascriptreact = {
            require("formatter.filetypes.javascript").prettiereslint
        },
        typescript = {
            require("formatter.filetypes.javascript").prettiereslint
        },
        typescriptreact = {
            require("formatter.filetypes.javascript").prettiereslint
        },
        html = {
            require("formatter.filetypes.html").prettier
        },
        css = {
            require("formatter.filetypes.css").prettier
        },
        yaml = {
            require("formatter.filetypes.yaml").prettier
        },
        toml = {
            require("formatter.filetypes.toml").taplo
        },
        rust = {
            require("formatter.filetypes.rust").rustfmt
        }
    }
}
