-- require("telescope").setup({
--   pickers = {
--     colorscheme = {
--       enable_preview = true
--     }
--   }
-- })

require('lualine').setup({
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- readonly | modified
        -- 0: just filename, 1: relative path, 2: absolute path, 3: absolute path, with tilde as the home directory
        -- 4: filename and parent dir, with tilde as the home directory
        path = 3,
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

-- cpu intensive when file is large
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "disable mini.indentscope for large buffer",
  pattern = "*",
  callback = function()
    local count = vim.fn.line('$')  -- line count
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    if count > 5000 or size > 1024*1024 then
      vim.b.miniindentscope_disable = true
    end
  end,
})

require('illuminate').configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },

  -- delay: delay in milliseconds
  delay = 200,

  -- filetype_overrides: filetype specific overrides.
  -- The keys are strings to represent the filetype while the values are tables that
  -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  filetype_overrides = {},
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
    'dirbuf',
    'dirvish',
    'fugitive',
  },
  -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
  -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
  filetypes_allowlist = {},

  -- large_file_cutoff: number of lines at which to use large_file_config
  -- The `under_cursor` option is disabled when this cutoff is hit
  -- 如果不限制, 当打开大文件时, nvim 会持续一段时间打满cpu
  large_file_cutoff = 2000,
  -- large_file_config: config to use for large files (based on large_file_cutoff).
  -- Supports the same keys passed to .configure
  -- If nil, vim-illuminate will be disabled for large files.
  large_file_overrides = {
    providers = { "lsp" },
  },
})

require('gitsigns').setup()

