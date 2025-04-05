return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        { "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "v", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "v", desc = "Save selected code snapshot in ~/Pictures/codesnaps" },
    },
    opts = {
        save_path = "~/Pictures/codesnaps",
        has_breadcrumbs = true,
        bg_theme = "sea",
        watermark = "root"
    },
}
