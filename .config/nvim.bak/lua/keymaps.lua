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

-- Exit references list
vim.keymap.set("n", "<Space>q", ":cclose<CR>", opts)

-----------------
-- Visual mode --
-----------------

vim.keymap.set("v", "S-j", ":MoveLineDown<CR>", opts)

vim.keymap.set("v", "S-k", ":MoveLineUp<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<C-a>", "ggVG", opts)
