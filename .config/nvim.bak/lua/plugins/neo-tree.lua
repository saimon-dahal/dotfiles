return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<Space>e", function()
                local neotree_win = nil
                local cur_win = vim.api.nvim_get_current_win()

                -- Look for the Neo-tree window
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
                    if bufname:match("neo%-tree filesystem") then
                        neotree_win = win
                        break
                    end
                end

                if neotree_win then
                    if neotree_win == cur_win then
                        -- Neo-tree is focused, so close it
                        vim.cmd("Neotree close")
                    else
                        -- Neo-tree is open but not focused, so focus it
                        vim.cmd("Neotree focus")
                    end
                else
                    -- Neo-tree is not open, so toggle (open) it
                    vim.cmd("Neotree toggle")
                end
            end, {})
            require("neo-tree").setup({
                enable_cursor_hijack = true,
                hide_root_node = true,
                window = {
                    width = 30,
                    mappings = {
                        ["Y"] = function(state)
                            local node = state.tree:get_node()
                            local filepath = node:get_id()
                            local filename = node.name
                            local modify = vim.fn.fnamemodify

                            local results = {
                                filepath,
                                modify(filepath, ":."),
                                modify(filepath, ":~"),
                                filename,
                                modify(filename, ":r"),
                                modify(filename, ":e"),
                            }

                            local options = {
                                "1. Absolute path: " .. results[1],
                                "2. Path relative to CWD: " .. results[2],
                                "3. Path relative to HOME: " .. results[3],
                                "4. Filename: " .. results[4],
                                "5. Filename without extension: " .. results[5],
                                "6. Extension of the filename: " .. results[6],
                            }

                            vim.ui.select(options, { prompt = "Choose to copy to clipboard:" }, function(choice)
                                if choice then
                                    local index = nil
                                    for i, option in ipairs(options) do
                                        if option == choice then
                                            index = i
                                            break
                                        end
                                    end

                                    if index then
                                        local result = results[index]
                                        vim.fn.setreg('"', result)
                                        vim.notify("Copied: " .. result)
                                    else
                                        print("Invalid choice.")
                                    end
                                end
                            end)
                        end,
                    },
                },
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        never_show = { ".git" },
                    },
                    window = {
                        mappings = {
                            ["<cr>"] = "open_with_window_picker",
                        },
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                },
                default_component_configs = {
                    git_status = {
                        symbols = {
                            added = "",
                            modified = "",
                            deleted = "✖",
                            renamed = "󰁕",
                            untracked = "",
                            ignored = "",
                            unstaged = "󰄱",
                            staged = "",
                            conflict = "",
                        },
                    },
                },
            })
        end,
    },
}
