return {
	{
		"seblyng/roslyn.nvim",
		enabled = true,
		ft = "cs",
		opts = {
			-- your configuration comes here; leave empty for default settings
		}
	},
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			'folke/snacks.nvim',
		},
		config = function()
			require("easy-dotnet").setup({
				lsp={
					enabled = false,
				},
				auto_bootstrap_namespace = {
					--block_scoped, file_scoped
					type = "file_scoped",
					enabled = true
				},
				picker = "snacks",
				get_sdk_path = function()
					return "~/.dotnet/sdk/8.0.407/"
				end,
				test_runner = {
					---@type "split" | "float" | "buf"
					viewmode = "float",
					enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
					noBuild = true,
					noRestore = true,
					icons = {
						passed = "",
						skipped = "",
						failed = "",
						success = "",
						reload = "",
						test = "",
						sln = "󰘐",
						project = "󰘐",
						dir = "",
						package = "",
					},
					mappings = {},
					-- mappings = {
					-- 	run_test_from_buffer = { lhs = "<leader>tr", desc = "run test from buffer" },
					-- 	filter_failed_tests = { lhs = "<leader>tfe", desc = "filter failed tests" },
					-- 	debug_test = { lhs = "<leader>td", desc = "debug test" },
					-- 	go_to_file = { lhs = "g", desc = "got to file" },
					-- 	run_all = { lhs = "<leader>tR", desc = "run all tests" },
					-- 	run = { lhs = "<leader>tr", desc = "run test" },
					-- 	peek_stacktrace = { lhs = "<leader>tp", desc = "peek stacktrace of failed test" },
					-- 	expand = { lhs = "o", desc = "expand" },
					-- 	expand_node = { lhs = "E", desc = "expand node" },
					-- 	expand_all = { lhs = "-", desc = "expand all" },
					-- 	collapse_all = { lhs = "W", desc = "collapse all" },
					-- 	close = { lhs = "q", desc = "close testrunner" },
					-- 	refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
					-- },
					--- Optional table of extra args e.g "--blame crash"
					additional_args = {}
				},
			})
		end,
		keys = {
			{ '<a-t>', function() require('easy-dotnet').testrunner() end, mode = 'n', 'Dotnet Test Runner' }
		},
	},
}
