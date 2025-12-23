return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = function()
			local cmp = require(".config.nvim.lua.plugins.code")
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
			cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert {
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					["<CR>"] = cmp.mapping.confirm { select = true },
					["<C-e>"] = cmp.mapping.abort(),
					["<Esc>"] = cmp.mapping.close(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
				},
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' }, -- For vsnip users.
					-- { name = 'nvim_lsp_signature_help' },
					-- { name = 'easy-dotnet' },
				}, {
					{ name = 'buffer' },
				}),
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('vue_ls', {
				capabilities = capabilities,
				filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
				init_options = {
					vue = {
						hybridMode = false,
					},
					typescript = {
						tsdk = vim.fn.expand(
							"~/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"
						),
					},
				},
			})

			vim.lsp.config('lua_ls', {
				capabilities = capabilities,
				settings = {
					Lua = {
					},
				},
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							version = 'LuaJIT'
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
							}
						}
					})
				end,
			})

			vim.lsp.config('gdscript', {})
			-- vim.lsp.config('ts_ls', {})

			-- lspconfig.gdscript.setup({
			-- 	name = "godot",
			-- 	cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			-- })
		end,
		keys = {
			{ '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Actions' },
			{ '<leader>rn', vim.lsp.buf.rename,      desc = 'Rename' },
		}
	},
	{
		"ray-x/lsp_signature.nvim",
		enabled = true,
		event = "InsertEnter",
		opts = {
			-- cfg options
			hint_enable = false,
			-- floating_window_above_cur_line = false,
		},
		config = function(_, opts)
			require('lsp_signature').setup(opts);
		end,
		keys = {
			{ '<c-k>', function() require('lsp_signature').toggle_float_win() end, mode = 'n', desc = 'Toggle LSP Signature', silent = true }
		}
	},
}
