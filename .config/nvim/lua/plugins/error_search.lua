-- Function to get diagnostic under cursor
local function get_diagnostic_under_cursor()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
	if #diagnostics == 0 then
		return nil
	end
	return diagnostics[1]
end

local function url_encode(str)
	str = str:gsub(" ", "+")
	str = str:gsub("([^%w%-_%.~%+])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	return str
end

local function google_search_error()
	local diagnostic = get_diagnostic_under_cursor()
	if not diagnostic then
		print("No diagnostic found under cursor.")
		return
	end

	-- Clean message: remove quotes
	local message = diagnostic.message:gsub('"', "")
	local code = diagnostic.code or ""
	local ft = vim.bo.filetype or "programming"

	-- Build query with language in front
	local query = ft .. " " .. (code ~= "" and (code .. " " .. message) or message)

	local url = "https://www.google.com/search?q=" .. url_encode(query)
	vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

vim.keymap.set("n", "<leader>ge", google_search_error, { desc = "Google search error under cursor" })
