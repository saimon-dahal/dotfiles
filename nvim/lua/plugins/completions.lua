return {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    -- Additional completion sources
    { "hrsh7th/cmp-nvim-lua" },        -- Lua neovim API completion
    { "kdheepak/cmp-latex-symbols" },  -- For latex symbols in math/science
    { "jc-doyle/cmp-pandoc-references" }, -- For academic citations
    { "onsails/lspkind.nvim" },        -- VS Code-like pictograms
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- Load friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Load Python docstring snippets
            luasnip.filetype_extend("python", { "python-docstring" })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        menu = {
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                            latex_symbols = "[Tex]",
                            pandoc_references = "[Ref]",
                        },
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                -- Sorted sources for different contexts
                sources = cmp.config.sources({
                    { name = "nvim_lsp",          priority = 1000 },
                    { name = "nvim_lua",          priority = 800 },
                    { name = "luasnip",           priority = 750 },
                    { name = "latex_symbols",     priority = 700 },
                    { name = "pandoc_references", priority = 700 },
                    { name = "path",              priority = 500 },
                    { name = "buffer",            priority = 250 },
                }),
                -- Enable ghost text
                experimental = {
                    ghost_text = true,
                },
                -- Special matching for Python imports
                matching = {
                    disallow_partial_fuzzy_matching = false,
                },
            })

            -- Special setup for Python docstrings
            luasnip.config.set_config({
                enable_autosnippets = true,
                store_selection_keys = "<Tab>",
            })

            -- Command line setup
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        options = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })
        end,
    },
}
