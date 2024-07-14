-- automatically install if not exist
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- installed extensions: coc-sumneko-lua(lua lsp), coc-snippets, coc-marketplace
  use {'neoclide/coc.nvim', branch = 'release'}

  -- install and manage LSP servers, DAP servers, linters, and formatters.
  use "williamboman/mason.nvim"

  -- lua functions collection
  use "nvim-lua/plenary.nvim"

  -- note: TSUpdate will cause Packer to fail upon the first installation.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- show code context
  use "nvim-treesitter/nvim-treesitter-context"

  -- visualize and operate on indent scope
  use "echasnovski/mini.indentscope"

  -- use {
  --   'nvim-telescope/telescope.nvim', tag = '0.1.x',
  --   requires = {
  --     {'nvim-lua/plenary.nvim'},
  --     {'nvim-treesitter/nvim-treesitter'}
  --   }
  -- }

  use {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" }
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }

  use "mhinz/vim-startify"

  -- usage: gcc
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- v3 has huge break change
  use {
    "folke/which-key.nvim",
    tag = "v2.1.0",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'jiangmiao/auto-pairs'
  -- colored parentheses
  use 'luochen1990/rainbow'

  -- automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
  -- 常见报错是因为没有对应语言的lsp 或者 tree-sitter parser, 安装tree-sitter parser `:TsInstall language`
  use 'RRethy/vim-illuminate'

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- usage: :Git blame
  use 'tpope/vim-fugitive'

  use "lewis6991/gitsigns.nvim"

  use {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = { "nvim-lua/plenary.nvim" },
  }

  use 'ianva/vim-youdao-translater'

  use 'solarnz/thrift.vim'

  -- colorscheme
  use "ellisonleao/gruvbox.nvim"
  use "folke/tokyonight.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "rebelot/kanagawa.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

