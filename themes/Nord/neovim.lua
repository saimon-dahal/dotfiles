vim.pack.add({
	{ src = "https://github.com/shaunsingh/nord.nvim" },
})
vim.cmd("colorscheme nord")

local function set_minipick_highlights()
	-- Nord palette
	vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { fg = "#A3BE8C", bold = true })  -- greenish highlight
	vim.api.nvim_set_hl(0, "MiniPickMatch", { fg = "#EBCB8B" })                       -- warm yellow accent
	vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = "#4C566A" })                       -- subtle gray border
	vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#D8DEE9", bg = "#2E3440", bold = true }) -- main fg/bg
	vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = "#D8DEE9", bg = "#2E3440" })       -- consistent background
	vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", { fg = "#4C566A" })                -- muted border tone
end

set_minipick_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_minipick_highlights,
})
