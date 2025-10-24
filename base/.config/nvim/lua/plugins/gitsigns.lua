require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 1000, -- milliseconds before showing blame (1 second)
		virt_text_pos = "eol", -- or "overlay", "right_align"
	},
})
