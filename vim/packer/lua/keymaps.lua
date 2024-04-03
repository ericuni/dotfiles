-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', telescope.find_files, {})
vim.keymap.set('n', '<c-e>', telescope.buffers, {})

-- youdao translator
vim.keymap.set('n', '<c-t>', ':<C-u>Ydc<CR>', { silent = true })
vim.keymap.set('v', '<c-t>', ':<C-u>Ydv<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>yd', ':<C-u>Yde<CR>', {})

-- which key
local wk = require('which-key')
wk.register({
  f = {
    name = "File",
    g = { "<cmd>Telescope live_grep<cr>", "live Grep" },
    t = { "<cmd>terminal<cr>i", "Terminal" },
    f = { "<cmd>Telescope find_files<cr>", "find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Help tags" }
  },
  t = { "<cmd>terminal<cr>i", "Terminal" },
  s = {
    name = "Search",
    o = { "<cmd>Telescope vim_options<cr>", "Options" },
    k = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
  },
  g = {
    name = "Git",
    b = { "<cmd>Git blame<cr>", "git Blame" },
    g = { "<cmd>LazyGit<cr>", "lazyGit" },
    c = { "<cmd>Telescope git_commits<CR>", "Commits" },
    s = { "<cmd>Telescope git_status<CR>", "Status" }
  },
  c = {
    name = "code",
    r = { "<Plug>(coc-rename)", "Rename" },
    f = { "<cmd>Format <cr>", "Format" },
    i = { "<cmd>OR <cr>", "organize Imports" },
    d = { "<cmd>CocList diagnostics<cr>", "show all Diagnostics" },
    o = { "<cmd>CocList outline<cr>", "Outline to find symbols of current document" },
    a = { "<Plug>(coc-codeaction-source)", "code Actions for current file" },
    c = {
      name = "Coc",
      e = { "<cmd>CocList extensions<cr>", "CoC extensions" }
    }
  },
  -- y = { "<cmd><c-u>Yde<cr>", "Youdao translator" }
}, { prefix = "<leader>" })
