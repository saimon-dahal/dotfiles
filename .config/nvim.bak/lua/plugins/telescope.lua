return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-s>"] = actions.select_vertical,
                        },
                    },
                    selection_strategy = "reset",
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", function()
                builtin.find_files({
                    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
                })
            end, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            require("telescope").load_extension("undo")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
