return {
	"s1n7ax/nvim-window-picker",
	config = function()
		require("window-picker").setup({
			autoselect_one = false,
			include_current = true,
		})
	end,
}
