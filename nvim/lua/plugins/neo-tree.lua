
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
        filesystem = {
          filtered_items = {
            visible = true,
            never_show = { ".git" },
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added     = "",  -- New files
              modified  = "",  -- Modified files
              deleted   = "",  -- Deleted files
              renamed   = "󰁕",  -- Renamed files
              untracked = "",  -- Untracked files
              ignored   = "",  -- Ignored files
              unstaged  = "󰄱",  -- Unstaged changes
              staged    = "",  -- Staged changes
              conflict  = "",  -- Merge conflicts
            },
          },
        },
      })
    end,
  },
}

