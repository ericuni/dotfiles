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

  use {'neoclide/coc.nvim', branch = 'release'}

  -- install and manage LSP servers, DAP servers, linters, and formatters.
  use "williamboman/mason.nvim"

  use { "ellisonleao/gruvbox.nvim" }

  -- lua functions collection
  use "nvim-lua/plenary.nvim"

  -- note: TSUpdate will cause Packer to fail upon the first installation.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-treesitter/nvim-treesitter'}
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

  use {
    "folke/which-key.nvim",
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

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- usage: :Git blame
  use 'tpope/vim-fugitive'

  use {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {"nvim-lua/plenary.nvim"},
  }

  use 'ianva/vim-youdao-translater'

  use 'solarnz/thrift.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

