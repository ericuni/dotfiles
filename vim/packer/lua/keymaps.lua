local fzf = require('fzf-lua')
vim.keymap.set('n', '<c-p>', fzf.files, { desc = "find File with Path" })
vim.keymap.set('n', '<c-e>', fzf.buffers, { desc = "find Buffer" })

-- which key
local wk = require('which-key')
wk.register({
  ["<space>"] = { "<cmd>FzfLua files<cr>", "find File" },
  b = {"<cmd>FzfLua buffers<cr>", "Buffers"},
  ["/"] = {"<cmd>FzfLua live_grep<cr>", "live Grep"},
  t = { "<cmd>terminal<cr>i", "Terminal" },
  j = { "<cmd>%!jq .<cr>", "Json file format"},

  f = {
    name = "File",
    e = {"<cmd>Neotree<cr>", "Explorer neotree"},
  },
  s = {
    name = "Search",
    -- o = { "<cmd>Telescope vim_options<cr>", "Options" },
    c = { "<cmd>FzfLua commands<cr>", "neovim Commands" },
    f = { "<cmd>FzfLua builtin<cr>", "Fzf-lua builtin commands" },
    h = { "<cmd>FzfLua help_tags<cr>", "Help tags" },
    k = { "<cmd>FzfLua keymaps<cr>", "Key maps" },
    m = { "<cmd>FzfLua manpages<cr>", "Man pages" },
  },
  g = {
    name = "Git",
    b = { "<cmd>Git blame<cr>", "git Blame" },
    g = { "<cmd>LazyGit<cr>", "lazyGit" },
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
  u = {
    name = "Ui",
    s = {function() vim.opt.spell = not(vim.opt.spell:get()) end, "toggle Spell"},
    n = {function() vim.opt.nu = not(vim.opt.nu:get()) vim.opt.rnu = not(vim.opt.rnu:get()) end, "toggle Number"},
    i = {function() vim.b.miniindentscope_disable = not(vim.b.miniindentscope_disable) end, "toggle indentscope"},
    c = {"<cmd>FzfLua colorschemes<cr>", "Colorscheme"},
  },
  y = {
    name = "Youdao",
    c = {"<cmd>Ydc<cr>", "translate Cusor word" },
    i = {"<cmd>Yde<cr>", "Input" },
  },
}, { prefix = "<leader>" })

