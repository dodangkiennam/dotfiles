require("config.lazy")

-- vim configuration
local vim = vim

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 1
-- vim.opt.foldnestmax = 3

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.clipboard = "unnamedplus"

-- custom commands
vim.api.nvim_create_user_command("CpCurrentBufferDirPath", function() vim.fn.setreg("+", vim.fn.expand("%:p:h")) end, {})

-- custom color scheme
-- vim.cmd("colorscheme sonokai")
vim.cmd('hi! LineNr guibg=none ctermbg=none')
-- vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
-- vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
-- vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
-- vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
-- vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')

-- nvim-ufo configs
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- snacks
vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#316c71", bg = "none", nocombine = true })

-- doge
vim.g.doge_mapping = '<Leader>dg'

-- avalonia
local function godot()
	-- paths to check for project.godot file
	local paths_to_check = { '/', '/../' }
	local is_godot_project = false
	local godot_project_path = ''
	local cwd = vim.fn.getcwd()

	-- iterate over paths and check
	for key, value in pairs(paths_to_check) do
		if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
			is_godot_project = true
			godot_project_path = cwd .. value
			break
		end
	end

	-- check if server is already running in godot project path
	local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
	-- start server, if not already running
	if is_godot_project and not is_server_running then
		vim.fn.serverstart(godot_project_path .. '/server.pipe')
	end
end

godot()

-- avalonia
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	pattern = { "*.axaml" },
	callback = function(event)
		vim.lsp.start {
			name = "avalonia",
			cmd = { "avalonia-ls" },
			root_dir = vim.fn.getcwd(),
		}
	end
})
vim.filetype.add({
	extension = {
		axaml = "xml",
	},
})
