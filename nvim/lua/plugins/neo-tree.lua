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
			vim.keymap.set("n", "<Space>e", ":Neotree toggle<CR>", {})
			require("neo-tree").setup({
				window = {
					width = 30,
				},
				filesystem = {
					filtered_items = {
						visible = true,
						never_show = { ".git" },
					},
					window = {
						mappings = {
							["<cr>"] = "open_with_window_picker",
						},
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
