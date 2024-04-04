-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', telescope.find_files, {})
vim.keymap.set('n', '<c-e>', telescope.buffers, {})

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
  ["/"] = {"<cmd>Telescope live_grep<cr>", "live Grep"},

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
    name = "Code",
    r = { "<Plug>(coc-rename)", "Rename" },
    f = { "<cmd>Format <cr>", "Format" },
    i = { "<cmd>OR <cr>", "organize Imports" },
    d = { "<cmd>CocList diagnostics<cr>", "show all Diagnostics" },
    o = { "<cmd>CocList outline<cr>", "Outline to find symbols of current document" },
    a = { "<Plug>(coc-codeaction-source)", "code Actions for current file" },
    c = {
      name = "Coc",
      e = { "<cmd>CocList extensions<cr>", "installed Extensions" },
      -- :CocInstall coc-marketplace
      m = { "<cmd>CocList marketplace<cr>", "Marketplace" },
    }
  },
  w = {
    name = "Window",
    w = {"<c-w>w<cr>", "switch to other Window"},
    ["-"] = {"<cmd>sp<cr>", "split window below(up is active)"},
    ["|"] = {"<cmd>vs<cr>", "split window right(left is active)"},
  },
  y = {
    name = "Youdao",
    c = {"<cmd>Ydc<cr>", "translate Cusor word" },
    i = {"<cmd>Yde<cr>", "Input" }
  },
  u = {
    name = "Ui",
    s = {function() vim.opt.spell = not(vim.opt.spell:get()) end, "toggle Spell"},
  }
}, { prefix = "<leader>" })

