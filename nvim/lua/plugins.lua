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
        "OXY2DEV/markview.nvim",
        lazy = false,      -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
      "folke/tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
	-- "tanvirtin/monokai.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
})
