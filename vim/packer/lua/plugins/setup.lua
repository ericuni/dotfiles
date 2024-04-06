
require("telescope").setup({
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
})

require('lualine').setup({
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- readonly | modified
        path = 2            -- 0:just filename, 1:relative path, 2:absolute path
      }
    }
  }
})

require('mason').setup()

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
}

require('mini.indentscope').setup()

