-- return {
--     "cpea2506/one_monokai.nvim",
--     name = 'one_monokai',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("one_monokai").setup({
--             transparent = true,
--             colors = {},
--             highlights = function(colors)
--                 return {}
--             end,
--             italics = true,
--         })
--
--         vim.cmd('colorscheme one_monokai')
--     end,
-- }
return {
    "webhooked/kanso.nvim",
    name = "kanso",
    lazy = false,
    priority = 1000,
    config = function()
        require("kanso").setup({
            transparent = true,
            italics = true,
            theme = "zen", -- Load "zen" theme
            background = { -- map the value of 'background' option to a theme
                dark = "zen", -- try "ink" !
            },
        })

        vim.cmd("colorscheme kanso")
    end,
}
