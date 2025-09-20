-- Using lazy.nvim

-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	name = "gruvbox",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("gruvbox").setup({
-- 			transparent_mode = true,
-- 			contrast = "soft",
-- 			palette_overrides = {
-- 				dark0 = "#32302f", -- background
-- 				light4 = "#a89984", -- main foreground
-- 				gray = "#928374", -- secondary text, comments
-- 				bright_blue = "#83a598", -- accent/highlight color
-- 				bright_red = "#83a598", -- reuse blue for things like errors if you want
-- 				bright_green = "#83a598", -- override all others to blue or gray
-- 				bright_yellow = "#928374",
-- 				bright_purple = "#928374",
-- 				bright_aqua = "#928374",
-- 				bright_orange = "#928374",
-- 				neutral_red = "#928374",
-- 				neutral_green = "#928374",
-- 				neutral_yellow = "#928374",
-- 				neutral_blue = "#83a598",
-- 				neutral_purple = "#928374",
-- 				neutral_aqua = "#928374",
-- 				neutral_orange = "#928374",
-- 			},
-- 		})
-- 		require("gruvbox").load()
-- 	end,
-- }

return {
    "shaunsingh/nord.nvim",
    name = "nord",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.nord_disable_background = true
        vim.cmd("colorscheme nord")
    end,
}
