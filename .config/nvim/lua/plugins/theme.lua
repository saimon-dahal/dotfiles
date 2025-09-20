vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { fg = "#ff7f50", bold = true }) -- coral
		vim.api.nvim_set_hl(0, "MiniPickMatch", { fg = "#87cefa" }) -- light sky blue
		vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = "#555555" }) -- gray
		vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#ECEFF4", bg = "#282828", bold = true })
		vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = "#f8f8f2", bg = "#282828" })
		vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", { fg = "#555555" })
	end,
})
