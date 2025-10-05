-- Set leader key early
local vim = vim
vim.g.mapleader = " "

-- Plugin management
vim.pack.add({
	-- ColorScheme
	{ src = "https://github.com/jacoborus/tender.vim" },

	-- Edit files and directories
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },

	-- file finder and grepping
	{ src = "https://github.com/echasnovski/mini.pick" },

	-- LSP plugins
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", name="luasnip" },

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },

	-- Git stuffs
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	-- Vim-Tmux Navigation
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- Auto Suggesstions
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },

	-- Lualine
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },

	-- autopairs
	{ src = "https://github.com/windwp/nvim-autopairs" },

	-- autosurround
	{ src = "https://github.com/kylechui/nvim-surround" },

	-- image rendering
	{ src = "https://github.com/3rd/image.nvim" },
})

-- Core settings and mappings
require("options")
require("keymaps")

-- Plugin setups
require("mini.pick").setup()
require("mason").setup()
require("lualine").setup()
require("nvim-surround").setup()
require("image").setup()

require("plugins.oil")
require("oil-git-status").setup()

require("plugins.lsp")
require("plugins.formatting")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.tmux-nvim")
require("plugins.gitsigns")
require("plugins.theme")
require("plugins.error_search")

-- Colorscheme
vim.cmd("colorscheme tender")
