-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'neoclide/coc.nvim', branch = 'release'}

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

  use 'ianva/vim-youdao-translater'

  use 'solarnz/thrift.vim'
end)

