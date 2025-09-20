vim.keymap.set("n", "<leader>lf", function()
	local ft = vim.bo.filetype
	local file = vim.fn.expand("%")
	if ft == "python" then
		vim.cmd("silent! write")
		vim.cmd("silent! !ruff format " .. file)
		vim.cmd("silent! !ruff check --select I --fix-only " .. file) -- I = isort
		vim.cmd("silent! !ruff check " .. file)
		vim.cmd("edit!")
	elseif ft == "lua" then
		vim.cmd("silent! write")
		vim.cmd("silent! !stylua " .. file)
		vim.cmd("edit!")
	elseif ft == "go" then
		vim.lsp.buf.format({ async = false })
	else
		vim.notify("No formatter defined for filetype: " .. ft, vim.log.levels.WARN)
	end
end, { desc = "Format File", noremap = true, silent = true })

local format_group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = "*.py",
	callback = function()
		local file = vim.fn.expand("%")
		vim.cmd("silent! !ruff format " .. file)
		vim.cmd("silent! !ruff check --select I --fix-only " .. file)
		vim.cmd("edit!")
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = "*.lua",
	callback = function()
		local file = vim.fn.expand("%")
		vim.cmd("silent! !stylua " .. file)
		vim.cmd("edit!")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_group,
	pattern = "*.go",
	callback = function()
		local file = vim.fn.expand("%")
		vim.cmd("silent! write")
		vim.cmd("silent! !gofumpt -w " .. file)
		vim.cmd("edit!")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("RuffDiagnostics", { clear = true }),
	pattern = "*.py",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local file = vim.fn.expand("%")
		vim.fn.jobstart({ "ruff", "check", "--output-format=json", file }, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if not data then
					return
				end
				local diagnostics = {}
				for _, line in ipairs(data) do
					if line ~= "" then
						local ok, decoded = pcall(vim.json.decode, line)
						if ok and decoded then
							for _, d in ipairs(decoded) do
								table.insert(diagnostics, {
									lnum = (d.location and d.location.row or 1) - 1,
									col = (d.location and d.location.column or 1) - 1,
									message = d.message or "",
									severity = vim.diagnostic.severity.WARN,
									source = "ruff",
								})
							end
						end
					end
				end
				vim.diagnostic.set(vim.api.nvim_create_namespace("ruff"), bufnr, diagnostics)
			end,
		})
	end,
})
