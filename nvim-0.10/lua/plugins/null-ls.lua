return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        -- Create format-on-save autogroup
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                -- Python formatting
                null_ls.builtins.formatting.black.with({
                    extra_args = {
                        "--line-length=88",
                        "--target-version=py310",
                        "--fast",
                    },
                }),

                null_ls.builtins.formatting.isort.with({
                    extra_args = {
                        "--profile=black",
                        "--line-length=88",
                        "--multi-line=3",
                        "--trailing-comma",
                    },
                }),

                -- Python diagnostics
                null_ls.builtins.diagnostics.mypy.with({
                    extra_args = {
                        "--ignore-missing-imports",
                        "--check-untyped-defs",
                        "--disallow-untyped-defs",
                        "--disallow-incomplete-defs",
                    },
                }),

                -- null_ls.builtins.diagnostics.pylint.with({
                --     extra_args = {
                --         "--max-line-length=88",
                --         "--disable=C0111", -- Missing docstring
                --         "--disable=C0103", -- Invalid name
                --     },
                -- }),

                -- Keep Lua formatting
                null_ls.builtins.formatting.stylua,
            },

            -- Format on save configuration
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                timeout_ms = 5000,
                            })
                        end,
                    })
                end
            end,

            debug = false,
            log_level = "warn",
            update_in_insert = false,
            diagnostics_format = "[#{c}] #{m} (#{s})",
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}
