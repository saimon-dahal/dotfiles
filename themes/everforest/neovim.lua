vim.pack.add({
	{ src = "https://github.com/neanias/everforest-nvim", name = "everforest" },
})
vim.cmd("colorscheme everforest")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Everforest dark hard palette alignment
		vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { fg = "#a7c080", bold = true }) -- greenish highlight
		vim.api.nvim_set_hl(0, "MiniPickMatch", { fg = "#dbbc7f" }) -- warm yellow accent
		vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = "#4b565c" }) -- subtle gray border
		vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#d3c6aa", bg = "#2D353B", bold = true }) -- main fg/bg
		vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = "#d3c6aa", bg = "#2D353B" }) -- consistent background
		vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", { fg = "#4b565c" }) -- muted border tone
	end,
})
