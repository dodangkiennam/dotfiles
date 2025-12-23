return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				-- keymaps only work in insert mode
				["<Tab>"] = { "select_next", "snippet_backward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_forward", "fallback" },
				["<esc>"] = { "cancel", "hide", "fallback" },
				["<C-.>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-u>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true },
				list = {
					selection = {
						auto_insert = true,
						preselect = false,
					},
				},
				menu = {
					auto_show = false,
				},
			},
			signature = {
				enabled = true,
				trigger = {
					show_on_trigger_character = false,
					show_on_insert_on_trigger_character = false,
				},
				window = { show_documentation = false },
			},
			sources = {
				default = { "lazydev", "lsp", "easy-dotnet", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					["easy-dotnet"] = {
						name = "easy-dotnet",
						enabled = true,
						module = "easy-dotnet.completion.blink",
						score_offset = 10000,
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
		config = function()
			require("easy-dotnet").setup({
				picker = "snacks",
			})
		end,
	},
}
