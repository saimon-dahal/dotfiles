vim.g.mapleader = ','
-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}


-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

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

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Toggle nvim-tree
vim.keymap.set('n', '<Space>e', ':NvimTreeToggle<CR>', opts)

-- Telescope
local builtin = require('telescope.builtin')

-- Find files
vim.keymap.set('n', '<Space>sf', builtin.find_files, {})
-- Grep (search) in files
vim.keymap.set('n', '<Space>sg', builtin.live_grep, {})
-- Search in open buffers
vim.keymap.set('n', '<Space>sb', builtin.buffers, {})
-- Search for help tags
vim.keymap.set('n', '<Space>sh', builtin.help_tags, {})

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

-- Better indenting
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Find all references
vim.keymap.set('n', 'g r', ':FindAllReferences<CR>', opts)

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
