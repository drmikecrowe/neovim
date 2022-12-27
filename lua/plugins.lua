-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
  use 'windwp/nvim-autopairs' -- Autopairs, integrates with both cmp and treesitter

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'nvim-lualine/lualine.nvim' -- Fancier statusline

  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines

  -- prettier tabs
  use 'romgrk/barbar.nvim'

  -- nice diagnostic pane on the bottom
  use 'folke/lsp-trouble.nvim'

  -- support the missing lsp diagnostic colors
  use 'folke/lsp-colors.nvim'

  use 'numToStr/Comment.nvim' -- 'gc' to comment visual regions/lines

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Tree explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup()
    end,
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Lua
  use 'folke/which-key.nvim'

  -- formatter
  use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
  }

  use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup() end
  }

  -- Session management
  use {
    'jedrzejboczar/possession.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  use 'Pocco81/auto-save.nvim'
  use 'fedepujol/move.nvim'
  use {
    'natecraddock/workspaces.nvim',
    config= function()
      require('workspaces').setup({
        hooks = {
          open = { 'Telescope find_files' },
        }
      })
    end
  }

  use {
    'gbprod/yanky.nvim',
    config = function()
      require('yanky').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end
  }

  use 'ggandor/leap.nvim'


  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "mofiqul/dracula.nvim" -- Dracula colorscheme for neovim
  use "marko-cerovac/material.nvim" -- Material.nvim is a highly configurable colorscheme
  use "folke/tokyonight.nvim" -- dark and light Visual Studio Code TokyoNight theme
  use "rktjmp/lush.nvim" -- Lush is aims to make colorscheme creation as painless as possible.
  use "sainnhe/sonokai"
  use "shaunsingh/nord.nvim" -- Nord Color Palette
  use "rebelot/kanagawa.nvim" -- painting by Katsushika Hokusai.
  use "edeneast/nightfox.nvim" -- Nightfox highly customizable theme
  use "mofiqul/vscode.nvim" -- vscode light and dark theme
  use "ishan9299/nvim-solarized-lua" -- solarized
  use "luisiacc/gruvbox-baby" -- gruvbox
  use "mhartington/oceanic-next" -- oceanic next theme
  use "sainnhe/everforest" -- Everforest
  use "romgrk/doom-one.vim" -- Doom One
  use "briones-gabriel/darcula-solid.nvim" -- Darcula

  use 'norcalli/nvim-colorizer.lua'

  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
