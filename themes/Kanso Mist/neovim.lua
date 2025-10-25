vim.pack.add({
	{ src = "https://github.com/webhooked/kanso.nvim" },
})
vim.cmd("colorscheme kanso-mist")

local function set_minipick_highlights()
  -- Match (current) = green
  vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {
    fg = "#98BB6C",
    bold = true,
  })

  -- Match = yellow
  vim.api.nvim_set_hl(0, "MiniPickMatch", {
    fg = "#DCA561",
  })

  -- Borders (use mistBg3)
  vim.api.nvim_set_hl(0, "MiniPickBorder", {
    fg = "#5C6066",
  })
  vim.api.nvim_set_hl(0, "MiniPickPreviewBorder", {
    fg = "#5C6066",
  })

  -- Prompt / Normal (use mistBg0 + fg)
  vim.api.nvim_set_hl(0, "MiniPickPrompt", {
    fg = "#C5C9C7",
    bg = "#22262D",
    bold = true,
  })
  vim.api.nvim_set_hl(0, "MiniPickNormal", {
    fg = "#C5C9C7",
    bg = "#22262D",
  })
end

set_minipick_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_minipick_highlights,
})
