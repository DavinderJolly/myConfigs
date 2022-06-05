if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'

if has("nvim")
  Plug 'gpanders/editorconfig.nvim'
  Plug 'tpope/vim-commentary'
  Plug 'ful1e5/onedark.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'
  Plug 'onsails/lspkind-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'github/copilot.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'mattn/emmet-vim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'lewis6991/gitsigns.nvim'
endif

call plug#end()
