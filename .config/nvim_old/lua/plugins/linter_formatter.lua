return {
	{
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				javascript = { 'eslint' },
				typescript = { 'eslint' },
				vue = { 'eslint' },
			}
			-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			-- 	callback = function()
			-- 		require("lint").try_lint()
			-- 	end,
			-- })
			vim.api.nvim_create_user_command("Lint", function()
				require("lint").try_lint()
			end, {})
		end,
	},
	{
		'stevearc/conform.nvim',
		opts = {
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				vue = { 'prettier' },
				html = { 'prettier' },
				css = { 'prettier' },
				json = { 'prettier' },
				cs = { 'csharpier' },
				gdscript = { 'gdformat' },
				xml = { 'xmlprettier' },
			},
			format_after_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters = {
				csharpier = {
					command = 'csharpier',
					args = { "format" },
				},
				-- xmlformatter = {
				-- 	args = {
				-- 		'--indent=4',
				-- 		'--blanks',
				-- 		'--preserve-attributes',
				-- 		'$FILENAME',
				-- 	}
				-- },
				xmlprettier = {
					command = '$HOME/.local/share/nvim/mason/bin/prettier',
					args = {
						"--plugin",
						"$HOME/.nvm/versions/node/v23.10.0/lib/node_modules/@prettier/plugin-xml/src/plugin.js",
						"--tab-width",
						"4",
						"--bracket-same-line",
						"--xml-sort-attributes-by-key",
						'$FILENAME',
					}
				},
			}
		},
	},
}
