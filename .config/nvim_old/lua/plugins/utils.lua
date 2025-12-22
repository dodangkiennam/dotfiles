return {
	{
		'ThePrimeagen/vim-be-good',
	},
	{
		'rmagatti/auto-session',
		enabled = true,
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
			-- log_level = 'debug',
		},
	},
	{
		"m4xshen/hardtime.nvim",
		enabled = false,
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}
