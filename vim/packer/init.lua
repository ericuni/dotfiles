vim.g.mapleader=" "

require('plugins/plugins')
require('plugins/coc')

require('options')
require('keymaps')
require('autocmds')

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

require('mason').setup()

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
}

