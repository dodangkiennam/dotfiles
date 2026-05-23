return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "csharpier" },
				gdscript = { "gdformat" },
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({
						timeout_ms = 2000,
					})
				end,
				desc = "(Conform) Format buffer",
			},
		},
	},
}
