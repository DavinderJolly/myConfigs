if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

" old vim plugins used before neogit
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'

" Lexical features
Plug 'cohama/lexima.vim'

if has("nvim")

  " Theme
  Plug 'ful1e5/onedark.nvim'

  " Tree plugin because netrw weird on windows
  Plug 'nvim-tree/nvim-tree.lua'

  " EditorConfig files
  Plug 'gpanders/editorconfig.nvim'

  " Toggle Comments
  Plug 'tpope/vim-commentary'

  " Automatically install language servers
  Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
  Plug 'williamboman/mason-lspconfig.nvim'

  " Configure nvim's builtin lsp client
  Plug 'neovim/nvim-lspconfig'

  " Symbols in autocomplete
  Plug 'onsails/lspkind-nvim'

  " Plugins for highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'HiPhish/rainbow-delimiters.nvim'

  " Show AST created by treesitter
  Plug 'nvim-treesitter/playground'

  " Autocompletion plugins
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-calc'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'f3fora/cmp-spell'

  " Snippets
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  " Status line
  Plug 'nvim-lualine/lualine.nvim'

  " File Icons
  Plug 'kyazdani42/nvim-web-devicons'

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

  " Git Plugins
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'NeogitOrg/neogit'

  " Hex editing
  Plug 'RaafatTurki/hex.nvim'

  " CPP Generate Implementations
  Plug 'DavinderJolly/generate.nvim'

  " Case Preserving Subverts / Subtitutes
  Plug 'tpope/vim-abolish'

endif

call plug#end()

