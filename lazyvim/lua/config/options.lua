-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.wrap = true
opt.mouse = ""
opt.swapfile = false
opt.colorcolumn = "+1"

-- zg: add word to dictionay located in lazyvim/spell/en.utf-8.add
opt.spelllang = { "en", "cjk" }
