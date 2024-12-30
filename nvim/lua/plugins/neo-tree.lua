
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
      require("neo-tree").setup({
        window = {
            width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = true,
            never_show = { ".git" },
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
                added     = "",
                modified  = "",
                deleted   = "✖",
                renamed   = "󰁕",
                untracked = "",
                ignored   = "",
                unstaged  = "󰄱",
                staged    = "",
                conflict  = "",
            },
          },
        },
      })
    end,
  },
}

