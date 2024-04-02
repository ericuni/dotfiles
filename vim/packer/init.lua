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

