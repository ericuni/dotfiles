-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-e>', builtin.buffers, {})

-- youdao translator
vim.keymap.set('n', '<c-t>', ':<C-u>Ydc<CR>', {silent = true})
vim.keymap.set('v', '<c-t>', ':<C-u>Ydv<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>yd', ':<C-u>Yde<CR>', {})

-- which key
local wk = require('which-key')
wk.register({
  f = {
    name = "File",
    g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
    t = {"<cmd>terminal<cr>i", "Terminal"},
    f = {"<cmd>Telescope find_files<cr>", "Find File"},
    h = {"<cmd>Telescope help_tags<cr>", "Help Tags"}
  },
  s = {
    name = "Search",
    o = {"<cmd>Telescope vim_options<cr>", "Options"},
    k = {"<cmd>Telescope keymaps<cr>", "Key Maps"},
  },
  g = {
    name = "Git",
    b = {"<cmd>Git blame<cr>", "Git blame"},
    g = {"<cmd>LazyGit<cr>", "LazyGit"},
    c = {"<cmd>Telescope git_commits<CR>", "Commits"},
    s = {"<cmd>Telescope git_status<CR>", "Status"}
  },
  c = {
    name = "code",
    r = {"<Plug>(coc-rename)", "Rename"}
  }
}, {prefix = "<leader>"})

