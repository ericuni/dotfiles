-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

local telescope = require("telescope.builtin")
keymap.set("n", "<c-p>", telescope.find_files) -- ctrl-p: find files in current directory
keymap.set("n", "<c-e>", "<cmd>Telescope buffers<cr>") -- ctrl-e: find buffers
