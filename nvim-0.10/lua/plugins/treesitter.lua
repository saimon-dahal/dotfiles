return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "lua",
                    "python",
                    "json",
                    "yaml",
                    "toml",
                    "regex",
                    "bash",
                    "markdown",
                    "markdown_inline",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                -- Additional Python-specific features
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                        scope_incremental = "<TAB>",
                    },
                },
                additional_vim_regex_highlighting = false,
            })
        end,
    },
}
