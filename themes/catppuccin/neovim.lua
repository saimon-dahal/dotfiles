vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})
vim.cmd("colorscheme catppuccin-mocha")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Catppuccin Mocha palette
		vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { fg = "#a6e3a1", bold = true }) -- green highlight
		vim.api.nvim_set_hl(0, "MiniPickMatch", { fg = "#f9e2af" }) -- yellow accent
		vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = "#585b70" }) -- subtle gray border
		vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#cdd6f4", bg = "#181827", bold = true })
		vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = "#cdd6f4", bg = "#181827" })
		vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", { fg = "#585b70" }) -- muted border tone
	end,
})
