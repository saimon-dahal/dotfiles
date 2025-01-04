local opts = {
    noremap = true,
    silent = true,
}

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-----------------
-- Normal mode --
-----------------
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<Space>sv", ":vsplit<Return><C-w>w", opts)

-- Move window
vim.keymap.set("n", "<Space>", "<C-w>w", opts)
vim.keymap.set("", "<C-h>", "<C-w>h", opts)
vim.keymap.set("", "<C-k>", "<C-w>k", opts)
vim.keymap.set("", "<C-j>", "<C-w>j", opts)
vim.keymap.set("", "<C-l>", "<C-w>l", opts)

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><", opts)
vim.keymap.set("n", "<C-w><right>", "<C-w>>", opts)
vim.keymap.set("n", "<C-w><up>", "<C-w>+", opts)
vim.keymap.set("n", "<C-w><down>", "<C-w>-", opts)

-- Exit references list
vim.keymap.set("n", "<Space>q", ":cclose<CR>", opts)

-----------------
-- Visual mode --
-----------------

vim.keymap.set("v", "S-j", ":MoveLineDown<CR>", opts)

vim.keymap.set("v", "S-k", ":MoveLineUp<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
