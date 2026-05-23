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
				"stylua", -- lua
				"csharpier", -- c#
				"gdscript-formatter", -- godot
				-- lsp
				"lua-language-server", -- lua
				"gdtoolkit", -- godot
			},
			run_on_start = false,
		},
	},
}
