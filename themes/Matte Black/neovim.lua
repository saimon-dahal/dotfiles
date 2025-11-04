vim.pack.add({
	{ src = "https://github.com/ficd0/ashen.nvim", name="ashen"},
})
vim.cmd("colorscheme ashen")

local function set_minipick_highlights()
  -- Match (current) = amber
  vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {
    fg = "#F59E0B",
    bold = true,
  })

  -- Match = amber (slightly muted)
  vim.api.nvim_set_hl(0, "MiniPickMatch", {
    fg = "#EAEAEA",
  })

  -- Borders
  vim.api.nvim_set_hl(0, "MiniPickBorder", {
    fg = "#8A8A8D",
  })
  vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", {
    fg = "#8A8A8D",
  })

  -- Prompt / Normal
  vim.api.nvim_set_hl(0, "MiniPickPrompt", {
    fg = "#EAEAEA",
    bg = "#121212",
    bold = true,
  })
  vim.api.nvim_set_hl(0, "MiniPickNormal", {
    fg = "#EAEAEA",
    bg = "#121212",
  })
end

set_minipick_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_minipick_highlights,
})
