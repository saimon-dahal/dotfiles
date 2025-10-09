require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"lua",
		"go",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 3,
	trim_scope = "outer",
})
