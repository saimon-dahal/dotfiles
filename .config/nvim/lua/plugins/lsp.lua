-- Setup nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For luasnip users
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
	completion = {
		completeopt = "menu,menuone,noselect",
	},
	experimental = {
		ghost_text = true,
	},
})

-- Setup capabilities for LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = require("cmp_nvim_lsp")
capabilities = cmp_lsp.default_capabilities(capabilities)

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(".git", "pyproject.toml"),
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern(".git"),
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		local map = vim.keymap.set

		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "go", vim.lsp.buf.type_definition, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "gs", vim.lsp.buf.signature_help, opts)
		map("n", "gc", vim.lsp.buf.rename, opts)
		map({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		map("n", "<F4>", vim.lsp.buf.code_action, opts)
	end,
})

vim.cmd("set completeopt+=noselect")

-- Enable LSP servers
vim.lsp.enable({ "pyright", "luals", "gopls" })
