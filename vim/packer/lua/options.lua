-- vim.opt if for things you would set in vimscript. vim.g is for things you'd let.

vim.g.mapleader=" "

local opt = vim.opt

opt.wrap = true
opt.mouse = ""
opt.swapfile = false
opt.colorcolumn = "121"
opt.laststatus = 2

opt.nu = true
opt.rnu = true

-- zg: add word to dictionay located in lazyvim/spell/en.utf-8.add
opt.spelllang = { "en", "cjk" }

