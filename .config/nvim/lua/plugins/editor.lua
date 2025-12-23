return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {},
		config = function()
			require("nvim-treesitter").install({
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
				"gdscript",
				"godot_resource",
				"gdshader",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		opts = {},
		keys = {
			{
				"af",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Function outer",
			},
			{
				"if",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Function inner",
			},
			{
				"ac",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Class outer",
			},
			{
				"ic",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Class inner",
			},
			{
				"aa",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Parameter outer",
			},
			{
				"ia",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Parameter inner",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {},
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			auto_restore = false,
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			-- log_level = 'debug',
			session_lens = {
				picker = "snacks",
				picker_opts = {},
			},
			bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			harpoon:extend({
				UI_CREATE = function(cx)
					vim.keymap.set("n", "<C-v>", function()
						harpoon.ui:select_menu_item({ vsplit = true })
					end, { buffer = cx.bufnr })

					vim.keymap.set("n", "<C-s>", function()
						harpoon.ui:select_menu_item({ split = true })
					end, { buffer = cx.bufnr })

					vim.keymap.set("n", "<C-t>", function()
						harpoon.ui:select_menu_item({ tabedit = true })
					end, { buffer = cx.bufnr })
				end,
			})

			local harpoon_extensions = require("harpoon.extensions")
			harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
		end,
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				mode = "n",
				desc = "(Harpoon) Mark file",
			},
			{
				"<leader>hl",
				function()
					require("harpoon"):list():next()
				end,
				mode = "n",
				desc = "(Harpoon) Navigate to next mark",
			},
			{
				"<leader>hh",
				function()
					require("harpoon"):list():prev()
				end,
				mode = "n",
				desc = "(Harpoon) Navigate to prev mark",
			},
			{
				"<leader>hm",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				mode = "n",
				desc = "(Harpoon) Toggle quick menu",
			},
			{
				"<leader>hs",
				function()
					local harpoon = require("harpoon")
					local normalize_list = function(t)
						local normalized = {}
						for _, v in pairs(t) do
							if v ~= nil then
								table.insert(normalized, v)
							end
						end
						return normalized
					end
					Snacks.picker({
						finder = function()
							local file_paths = {}
							local list = normalize_list(harpoon:list().items)
							for i, item in ipairs(list) do
								table.insert(file_paths, { text = item.value, file = item.value })
							end
							return file_paths
						end,
						win = {
							input = {
								keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
							},
							list = {
								keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
							},
						},
						actions = {
							harpoon_delete = function(picker, item)
								local to_remove = item or picker:selected()
								harpoon:list():remove({ value = to_remove.text })
								harpoon:list().items = normalize_list(harpoon:list().items)
								picker:find({ refresh = true })
							end,
						},
					})
				end,
				mode = "n",
				desc = "(Harpoon) Search",
			},
		},
	},
}
