return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
        },

        config = function()
            -- Fold text: show number of lines folded with an icon
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d lines"):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        table.insert(newVirtText, { chunkText, chunk[2] })
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end

            require("ufo").setup({
                fold_virt_text_handler = handler,
                provider_selector = function(_, filetype)
                    local map = {
                        git = "", -- disable folding in git buffers
                        python = { "treesitter", "indent" },
                    }
                    return map[filetype] or { "treesitter", "indent" }
                end,
            })

            -- Recommended folding settings
            vim.o.foldcolumn = "0"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Keymaps
            -- vim.keymap.set("n", "za", function()
            --     require("ufo").toggleFold()
            -- end, { desc = "UFO: Toggle fold under cursor" })

            vim.keymap.set("n", "zO", require("ufo").openAllFolds, { desc = "UFO: Open all folds" })
            vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "UFO: Close all folds" })

            -- Peek inside fold or fallback to LSP hover
            vim.keymap.set("n", "zp", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = "UFO: Peek fold or hover" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
