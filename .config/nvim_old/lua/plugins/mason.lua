return {
	{
		"williamboman/mason.nvim",
		version = "^1.0.0",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tailwindcss",
					"volar",
					"ts_ls"
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require('mason-tool-installer').setup {
				ensure_installed = {
					-- formatters & linters
					"csharpier",
					"prettier",
					-- .net
					"rzls",
					"netcoredbg",
					"roslyn",
					-- godot
					"gdtoolkit",
				}
			}
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "coreclr" }
			})
		end
	},
}
