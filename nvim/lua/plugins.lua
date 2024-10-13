local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
		  "nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		version = "*",
		lazy = false,
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = {
		  'nvim-lua/plenary.nvim'
		},
        {'nvim-telescope/telescope-ui-select.nvim'},
        {'nvim-tree/nvim-web-devicons', enabled=vim.g.have_nerd_font},
	},
    {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
},
	{
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.black,
                },
            })
        end,
    },
	{
		'lewis6991/gitsigns.nvim',
		config = function()
		  require('gitsigns').setup()
		end
	  },
	  {
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equivalent to setup({}) function
	  },
	  {
        'ThePrimeagen/vim-be-good',
        cmd = "VimBeGood",  -- This makes the plugin load only when you run the command
        config = function()
            -- Optional: Add any additional configuration here if needed
        end
    },
	{
		'mg979/vim-visual-multi',
		branch = 'master'
	  },
	  {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
		  require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false, -- show the '~' characters after the end of buffers
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				notify = false,
				mini = false,
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})
		end
	  },

	-- "tanvirtin/monokai.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
})
