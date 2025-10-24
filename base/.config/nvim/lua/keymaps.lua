local opts = {
	noremap = true,
	silent = true,
}

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-----------------
-- Normal mode --
-----------------

vim.keymap.set("n", "<Space>sv", ":vsplit<Return><C-w>w", opts)

-- Resize window
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>lf", "vim.lsp.buf.format")

-- Plugins Keymaps --

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")

vim.keymap.set("n", "<leader>e", ":Oil<CR>")

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>")

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-----------------
-- Visual mode --
-----------------

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<C-a>", "ggVG", opts)

-- Reload theme with <leader>tr
vim.keymap.set("n", "<leader>tr", function()
	local theme_file = vim.fn.expand("~/.config/themes/current/neovim.lua")
	if vim.fn.filereadable(theme_file) == 1 then
		dofile(theme_file)
		vim.notify("Theme reloaded!", vim.log.levels.INFO)
	end
end, { desc = "Reload theme" })
