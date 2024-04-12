vim.g.mapleader = " "

require('plugins/plugins')
require('plugins/coc')
require('plugins/setup')

require('options')
require('keymaps')
require('autocmds')

vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme tokyonight]])

