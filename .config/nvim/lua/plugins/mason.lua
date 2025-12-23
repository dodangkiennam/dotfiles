return {
	{
		"mason-org/mason.nvim",
		lazy = true,
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- lazy = true,
		opts = {
			ensure_installed = {
				-- formatters
				'stylua', -- lua
				'csharpier', -- c#
				-- lsp
				'lua-language-server', -- lua
			},
			run_on_start = false,
		},
	},
}
