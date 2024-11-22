return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
            chunk = {
                enable=true,
                style = {
                    { fg = "#806d9c"},
                    { fg = "#f35336" },
                }
            }
    })
  end
}
