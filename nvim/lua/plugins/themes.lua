-- Lua

return {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    transparent = true,
    priority = 1000,
    config = function()
        require("poimandres").setup({
            bold_vert_split = true, -- use bold vertical separators
            dim_nc_background = true, -- dim 'non-current' window backgrounds
            disable_background = true, -- disable background
            disable_float_background = true, -- disable background for floats
            disable_italics = true, -- disable italics
        })
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
        vim.cmd("colorscheme poimandres")
    end,
}
