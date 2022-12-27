-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  hooks = {
    open = { "NvimTreeOpen", "Telescope find_files" },
  },
  extensions = {
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    }
  }
}

require('telescope').load_extension('possession')

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

