return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "csharpier" },
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				desc = "(Conform) Format buffer",
			},
		},
	},
}
