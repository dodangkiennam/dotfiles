local vim = vim

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.opt.foldmethod = 'expr'
-- vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 2
