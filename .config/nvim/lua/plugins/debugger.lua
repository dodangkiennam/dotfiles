return {
	{
		'mfussenegger/nvim-dap',
		priority = 51,
		enabled = true,
		config = function()
			local dap = require('dap')
			dap.adapters.coreclr = {
				type = 'executable',
				command = 'netcoredbg',
				args = { '--interpreter=vscode' }
			}

			dap.adapters.godot = {
				type = "server",
				host = '127.0.0.1',
				port = 6006,
			}

			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
				}
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
					end,
				},
			}

			local dotnet = require("easy-dotnet")
			local debug_dll = nil
			local function ensure_dll()
				if debug_dll ~= nil then
					return debug_dll
				end
				local dll = dotnet.get_debug_dll()
				debug_dll = dll
				return dll
			end

			for _, lang in ipairs({ "cs" }) do
				dap.configurations[lang] = {
					{
						log_level = "DEBUG",
						type = "netcoredbg",
						justMyCode = false,
						stopAtEntry = false,
						name = "Default",
						request = "launch",
						env = function()
							local dll = ensure_dll()
							local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
							return vars or nil
						end,
						program = function()
							require("overseer").enable_dap()
							local dll = ensure_dll()
							return dll.relative_dll_path
						end,
						cwd = function()
							local dll = ensure_dll()
							return dll.relative_project_path
						end,
						preLaunchTask = "Build .NET App With Spinner",
					},
				}

				dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
					debug_dll = nil
				end
			end
		end,
		keys = {
			{
				'<F3>',
				function() require('dapui').toggle() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP toggle UI'
			},
			{
				'<F4>',
				function() require('dap').terminate() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP terminate'
			},
			{
				'<F5>',
				function() require('dap').continue() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP launch or continue'
			},
			{
				'<F6>',
				function() require('dap').pause() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP pause (thread)'
			},
			{
				'<F9>',
				function() require('dap').step_over() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP step over'
			},
			{
				'<F10>',
				function() require('dap').step_into() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP step into'
			},

			{
				'<F11>',
				function() require('dap').step_out() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP step out'
			},
			{
				'<F12>',
				function() require('dap').step_back() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP step back'
			},

			{
				'<leader>dd',
				function() require('dap').disconnect({ terminateDebuggee = false }) end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP disconnect'
			},
			{
				'<leader>dt',
				function() require('dap').disconnect({ terminateDebuggee = true }) end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP disconnect and terminate'
			},
			{
				'<leader>db',
				function() require('dap').toggle_breakpoint() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP toggle breakpoint'
			},
			{
				'<leader>dc',
				function() require('dap').clear_breakpoints() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP clear breakpoints'
			},
			{
				'<leader>dB',
				function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP set breakpoint with condition'
			},
			{
				'<leader>dp',
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP set breakpoint with log point message'
			},
			{
				'<leader>da',
				function() require('dap').run() end,
				mode = { 'n', 'v' },
				silent = true,
				desc = 'DAP run'
			}
		}
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio"
		},
		config = function()
			local dapui = require("dapui")
			dapui.setup()

			local dap = require('dap')
			-- open Dap UI automatically when debug starts (e.g. after <F5>)
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			-- close Dap UI with :DapCloseUI
			vim.api.nvim_create_user_command("DapCloseUI", function()
				require("dapui").close()
			end, {})

			-- use <Alt-e> to eval expressions
			vim.keymap.set({ 'n', 'v' }, '<M-e>', function() require('dapui').eval() end)
		end,
		keys = {
			{ '<leader>duo', function() require('dapui').open() end,   mode = 'n', desc = 'DAP UI open' },
			{ '<leader>duc', function() require('dapui').close() end,  mode = 'n', desc = 'DAP UI close' },
			{ '<leader>dut', function() require('dapui').toggle() end, mode = 'n', desc = 'DAP UI toggle' },
		}
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		config = function()
			require("nvim-dap-virtual-text").setup()
		end
	},
}
