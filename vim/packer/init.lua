require('plugins/plugins')
require('plugins/coc')

require('options')
require('keymaps')

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require('lualine').setup({
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- readonly | modified
        path = 2  -- 0:just filename, 1:relative path, 2:absolute path
      }
    }
  }
})

-- [restore cursor position when opening a file](https://github.com/neovim/neovim/issues/16339)
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

local wk = require('which-key')
wk.register({
  f = {
    name = "File",
    f = {"<cmd>Telescope find_files<cr>", "Find File"},
    g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
    h = {"<cmd>Telescope help_tags<cr>", "Help Tags"}
  },
  s = {
    name = "Search",
    o = {"<cmd>Telescope vim_options<cr>", "Options"},
    k = {"<cmd>Telescope keymaps<cr>", "Key Maps"}
  },
  g = {
    name = "Git",
    c = {"<cmd>Telescope git_commits<CR>", "Commits"},
    s = {"<cmd>Telescope git_status<CR>", "Status"}
  }
}, {prefix = "<leader>"})

