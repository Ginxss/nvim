vim.g.is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.g.profile_light = false

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.signcolumn = "yes"

if not vim.g.is_windows then
	vim.opt.shell = "/usr/bin/fish"
end
