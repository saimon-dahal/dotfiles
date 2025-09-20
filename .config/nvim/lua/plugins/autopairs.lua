local npairs = require("nvim-autopairs")
npairs.setup({
	check_ts = true,
	enable_moveright = true,
})
-- _G.MUtils = {}
--
-- function _G.MUtils.tab_complete()
-- 	local npairs = require("nvim-autopairs")
-- 	local ts_utils = require("nvim-treesitter.ts_utils")
--
-- 	-- Check if cursor is just before a closing pair
-- 	if npairs.jump_next() then
-- 		return "" -- jump out of pair
-- 	else
-- 		return "\t" -- fallback: insert a tab
-- 	end
--     {}
-- end
