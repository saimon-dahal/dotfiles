return {
    "cpea2506/one_monokai.nvim",
    name = 'one_monokai',
    lazy = false,
    priority = 1000,
    config = function()
        require("one_monokai").setup({
            transparent = false,
            colors = {},
            highlights = function(colors)
                return {}
            end,
            italics = true,
        })

        vim.cmd('colorscheme one_monokai')
    end,
}
