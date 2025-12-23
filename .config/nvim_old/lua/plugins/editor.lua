return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				-- required parsers
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				-- additional parsers
				"html",
				"css",
				"tsx",
				"xml",
				"yaml",
				"json",
				"regex",
				"javascript",
				"typescript",
				-- vue
				"vue",
				-- c#
				"c_sharp",
				-- godot
				'gdscript',
				'godot_resource',
				'gdshader',
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Function Outer" },
						["if"] = { query = "@function.inner", desc = "Function Inner" },
						["ac"] = { query = "@class.outer", desc = "Class Outer" },
						["ic"] = { query = "@class.inner", desc = "Class Inner" },
						["as"] = { query = "@local.scope", query_group = "locals", desc = "Language scope" },
					},
					include_surrounding_whitespace = true,
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = "nvim-treesitter",
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {},
		config = true,
	},
	{
		'windwp/nvim-ts-autotag',
		event = "InsertEnter",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {} -- your configuration
	},
	{
		"kkoomen/vim-doge",
		enabled = false,
		config = function()
			-- doge_enable_mappings = 0
			doge_mapping = '<Leader>dg'
		end
	},
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"Issafalcon/neotest-dotnet",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dotnet")({
						discovery_root = 'solution',
					})
				}
			})
		end,
		keys = {
			{ '<leader>ts',  function() require("neotest").summary.toggle() end,              mode = "n", desc = "Toggle Summary tests" },
			{ '<leader>tb',  function() require("neotest").run.run(vim.fn.expand("%")) end,   mode = "n", desc = "Run tests in current buffer" },
			{ '<leader>trr', function() require("neotest").run.run() end,                     mode = "n", desc = "Run nearest test" },
			{ '<leader>trs', function() require("neotest").run.stop() end,                    mode = "n", desc = "Stop nearest test" },
			{ '<leader>td',  function() require("neotest").run.run({ strategy = "dap" }) end, mode = "n", desc = "Debug nearest test" },
			{ '<leader>ta',  function() require("neotest").run.attach() end,                  mode = "n", desc = "Attach nearest test" },
			{ '<leader>tw',  function() require("neotest").watch.toggle() end,                mode = "n", desc = "Toggle Watch tests" },
			{ '<leader>to',  function() require("neotest").output.open() end,                 mode = "n", desc = "Show output of tests" },
			{ '<leader>tO',  function() require("neotest").output_panel.toggle() end,         mode = "n", desc = "Toggle All test outputs panel" },
			{ '<leader>tC',  function() require("neotest").output_panel.toggle() end,         mode = "n", desc = "Clear All test outputs panel" },
		}
	},
	{
		"danymat/neogen",
		version = "*", -- stable version only
		config = function()
			require('neogen').setup {

				languages = {
					cs = {
						template = {
							annotation_convention = "xmldoc"
						}
					}
				}
			}

			local opts = { noremap = true, silent = true, desc = "Generate documentation comment" }
			vim.api.nvim_set_keymap("n", "<Leader>dg", ":lua require('neogen').generate()<CR>", opts)
		end,
	},
	{
		'ThePrimeagen/harpoon',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			global_settings = {
				-- tabline = true,
			},
			menu = {
			width = vim.api.nvim_win_get_width(0) / 2,
			}
		},
		keys = {
			{ '<leader>ha', function() require('harpoon.mark').add_file() end,        mode = 'n', desc = '(Harpoon) Mark file' },
			{ '<leader>hl', function() require('harpoon.ui').nav_next() end,          mode = 'n', desc = '(Harpoon) Navigate to next mark' },
			{ '<leader>hh', function() require('harpoon.ui').nav_prev() end,          mode = 'n', desc = '(Harpoon) Navigate to prev mark' },
			{ '<leader>hm', function() require('harpoon.ui').toggle_quick_menu() end, mode = 'n', desc = '(Harpoon) Toggle quick menu' },
		}
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = {
			'kevinhwang91/promise-async',
		},
		config = function()
			require('ufo').setup({
				provider_selector = function(bufnr, filetype, buftype)
					return {'treesitter', 'indent'}
				end
			})
		end,
	}
}
