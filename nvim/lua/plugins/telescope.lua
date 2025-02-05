return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-s>"] = actions.select_vertical,
						},
					},
					selection_strategy = "reset",
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
				})
			end, {})
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
