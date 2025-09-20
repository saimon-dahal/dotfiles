return {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
        parser = { comments = { "#", "//" } },
        display_mode = "border", -- Set display mode
        header_lnum = 1,         -- Header line number
        keymaps = {
            textobject_field_inner = { "if", mode = { "o", "x" } },
            textobject_field_outer = { "af", mode = { "o", "x" } },
            jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
            jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
            jump_next_row = { "<Enter>", mode = { "n", "v" } },
            jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },

    -- Automatically enable CsvView on CSV files
    init = function()
        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*.csv",
            callback = function()
                vim.cmd("CsvViewEnable display_mode=border header_lnum=1")
            end,
        })
    end,
}
