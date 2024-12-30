-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.cmd("set foldlevel=99")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.opt.foldenable = true
-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Toggle fold under cursor
vim.keymap.set('n', 'zo', 'zo', opts)  -- Open fold
vim.keymap.set('n', 'zc', 'zc', opts)  -- Close fold
vim.keymap.set('n', 'zA', 'zA', opts)  -- Toggle fold recursively

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Visual mode: Move line down (Shift + j)
vim.keymap.set('v', 'S-j', ':MoveLineDown<CR>', opts)

-- Visual mode: Move line up (Shift + k)
vim.keymap.set('v', 'S-k', ':MoveLineUp<CR>', opts)

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Toggle nvim-tree
vim.keymap.set('n', '<Space>e', ':Neotree toggle<CR>', opts)

-- Telescope
local builtin = require('telescope.builtin')

-- Find files
vim.keymap.set('n', '<Space>pf', builtin.find_files, {})
-- Grep (search) in files
vim.keymap.set('n', '<Space>pg', builtin.live_grep, {})
-- Search in open buffers
vim.keymap.set('n', '<Space>pb', builtin.buffers, {})
-- Search for help tags
vim.keymap.set('n', '<Space>ph', builtin.help_tags, {})

-- Split window
-- vim.keymap.set('n', '<Space>ss', ':split<Return><C-w>w', opts)
vim.keymap.set('n', '<Space>sv', ':vsplit<Return><C-w>w', opts)

-- Move window
vim.keymap.set('n', '<Space>', '<C-w>w', opts)
vim.keymap.set('', '<C-h>', '<C-w>h', opts)
vim.keymap.set('', '<C-k>', '<C-w>k', opts)
vim.keymap.set('', '<C-j>', '<C-w>j', opts)
vim.keymap.set('', '<C-l>', '<C-w>l', opts)

-- Resize window
vim.keymap.set('n', '<C-w><left>', '<C-w><', opts)
vim.keymap.set('n', '<C-w><right>', '<C-w>>', opts)
vim.keymap.set('n', '<C-w><up>', '<C-w>+', opts)
vim.keymap.set('n', '<C-w><down>', '<C-w>-', opts)

-- Find all references
vim.keymap.set('n', '<Space>gr', ':FindAllReferences<CR>', opts)

-- Exit references list
vim.keymap.set('n', '<Space>q', ':cclose<CR>', opts)

-- Telescope
vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{
        windblend = 10,
        previewer = false,
    })
end, {desc = '[/] Fuzzily search in current buffer'})


-- Highlight when yanking (copying) text

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- TROUBLE
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })

-- HARPOON
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-p>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():next()
end)
