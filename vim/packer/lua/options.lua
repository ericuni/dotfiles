-- vim.opt if for things you would set in vimscript. vim.g is for things you'd let.

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

-- zg: add word to dictionary located in spell/en.utf-8.add
-- zw: Like "zg" but mark the word as a wrong (bad) word.
-- opt.spell = false
opt.spelllang = { "en", "cjk" }


-- rainbow, enable
vim.g.rainbow_active = 1

-- do not change directory, run `:echo getcwd()` to see result
-- [vim working directory change when open from MRU](https://github.com/mhinz/vim-startify/issues/387)
vim.g.startify_change_to_dir = 0

