return {
	-- theme picker
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "night-owl",
						colorscheme = "night-owl",
					},
					{
						name = "sonokai",
						colorscheme = "sonokai",
					},
					{
						name = "kanagawa-wave",
						colorscheme = "kanagawa-wave",
					},
					{
						name = "kanagawa-dragon",
						colorscheme = "kanagawa-dragon",
					},
					{
						name = "kanagawa-lotus",
						colorscheme = "kanagawa-lotus",
					},
				},
			})
		end,
	},
	-- colorschemes
	{
		"oxfist/night-owl.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("night-owl").setup()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- transparent = true,
			keywordStyle = {
				italic = false,
			},
		},
	},
	{
		"sainnhe/sonokai",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_style = "shusia"
		end,
	},
	-- icon
	{
		"echasnovski/mini.icons",
		version = false,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { "mode", require("easy-dotnet.ui-modules.jobs").lualine },
				lualine_x = {
					function()
						return "s-" .. require("auto-session.lib").current_session_name(true)
					end,
				},
			},
		},
	},
}
