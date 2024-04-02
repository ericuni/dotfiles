-- vim.opt if for things you would set in vimscript. vim.g is for things you'd let.

vim.g.mapleader=" "

local opt = vim.opt

opt.wrap = true
opt.mouse = ""

opt.swapfile = false
opt.laststatus = 2

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.colorcolumn = "121"
opt.ruler = true
opt.cursorline = true

opt.nu = true
opt.rnu = true

opt.ic = true

-- zg: add word to dictionay located in lazyvim/spell/en.utf-8.add
opt.spelllang = { "en", "cjk" }


-- rainbow, enable
vim.g.rainbow_active = 1

-- do not change directory, run `:echo getcwd()` to see result
-- [vim working directory change when open from MRU](https://github.com/mhinz/vim-startify/issues/387)
vim.g.startify_change_to_dir = 0

