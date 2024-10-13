-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim
vim.opt.scrolloff  = 10             -- min num of screen lines to keep above and below cursor

-- Tab
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = false            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- Split windows
vim.opt.splitbelow = true      -- force all horizontal splits to go below current window
vim.opt.splitright = true      -- force all vertical splits to go to the right of current window

-- Set split separator to Unicode box drawing character
vim.opt.fillchars:append { vert = '│' }

-- Enable autosave
vim.opt.autowrite = true -- Automatically save before commands like :next and :make
vim.opt.autowriteall = true -- Automatically save before commands like :quit, :q, :shell, and :terminal

-- Enable vertical cursor line
vim.opt.cursorcolumn = true

-- Enable transparency
vim.opt.winblend = 15
vim.opt.pumblend = 15
vim.opt.termguicolors = true


-- show mode
vim.opt.showmode = false

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
