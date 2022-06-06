if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

" Git features
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Lexical features
Plug 'cohama/lexima.vim'

if has("nvim")
  " EditorConfig files
  Plug 'gpanders/editorconfig.nvim'

  " Toggle Comments
  Plug 'tpope/vim-commentary'

  " Theme
  Plug 'ful1e5/onedark.nvim'

  " Automatically install language servers
  Plug 'williamboman/nvim-lsp-installer'

  " Configure nvim's builtin lsp client
  Plug 'neovim/nvim-lspconfig'

  " Symbols in autocomplete
  Plug 'onsails/lspkind-nvim'

  " Plugins for highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'p00f/nvim-ts-rainbow'

  " Snippets
  Plug 'L3MON4D3/LuaSnip'

  " Autocompletion plugins
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'saadparwaiz1/cmp_luasnip'

  " Status line
  Plug 'nvim-lualine/lualine.nvim'

  " File Icons
  Plug 'kyazdani42/nvim-web-devicons'

  " Copilot
  Plug 'github/copilot.vim'

  " Custom functions
  Plug 'nvim-lua/plenary.nvim'

  " Fuzzy Finder
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'benfowler/telescope-luasnip.nvim'

  " TODO Comments and search using Telescope
  Plug 'folke/todo-comments.nvim'

  " Emmet Autocompletion
  Plug 'mattn/emmet-vim'

  " HTML Tag autocomplete and change
  Plug 'windwp/nvim-ts-autotag'

  " Show color rgb, hsl and hex colors in editor
  Plug 'norcalli/nvim-colorizer.lua'

  " Help with managing
  Plug 'lewis6991/gitsigns.nvim'

  " Auto save files on change when leaving insert mode
  Plug 'Pocco81/AutoSave.nvim'

  " Tree plugin because netrw weird on windows
  Plug 'kyazdani42/nvim-tree.lua'
endif

call plug#end()
