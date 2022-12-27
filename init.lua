require('user.autocmd')
require('user.options')

require('plugins')

require('plugin.comment')
require('plugin.whichkey')
require('plugin.lualine')
require('plugin.indentline')
require('plugin.nullls')
require('plugin.possession')
require('plugin.treesitter')
require('plugin.tree')
require('plugin.gitsigns')
require('plugin.telescope')

require('lsp')

require('user.keymaps')
require('user.colorscheme')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
