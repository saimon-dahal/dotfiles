vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.scrolloff = 10
vim.g.netrw_browse_split = 0

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showmode = false

vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.autowrite = true
vim.o.autowriteall = true

vim.o.cursorcolumn = true

vim.o.winblend = 15
vim.o.pumblend = 15
vim.o.termguicolors = true

vim.o.showmode = false

vim.o.signcolumn = "yes"

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.winborder = "rounded"

vim.opt.fillchars:append({ eob = " " })
vim.opt.fillchars:append({ vert = "│" })
vim.opt.completeopt = { "menuone", "noselect", "popup" }
