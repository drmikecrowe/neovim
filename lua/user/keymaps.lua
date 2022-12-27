-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`

local g = vim.g
local map = vim.keymap.set
local os = jit.os
local noremap = { noremap = true, silent = true }

map('i', 'jk', '<ESC>', noremap) -- exit insert mode
map('t', 'jk', '<C-\\><C-n>', noremap) -- exit insert mode

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)

-- Better indent
map("v", "<", "<gv", noremap)
map("v", ">", ">gv", noremap)

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', noremap)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", noremap)

-- Machine dependent shortcuts

-- On Mac use CMD
if os == 'OSX' then
  map('i', '<D-s>', '<ESC> :update <CR>', noremap) -- exit insert mode and save file
  map('n', '<D-s>', ':update<CR>', noremap) -- save file

  map('n', '<D-Right>', ':tabn<CR>', noremap) -- next tab
  map('n', '<D-Left>', ':tabp<CR>', noremap) -- previous tab
  map('n', '<D-Up>', ':bn!<CR>', noremap) -- next buffer
  map('n', '<D-Down>', ':bp!<CR>', noremap) -- previous buffer

  -- Move lines and blocks via move plugin
  map('n', '<D-j>', ':MoveLine(1)<CR>', noremap)
  map('n', '<D-k>', ':MoveLine(-1)<CR>', noremap)
  map('v', '<D-j>', ':MoveBlock(1)<CR>', noremap)
  map('v', '<D-k>', ':MoveBlock(-1)<CR>', noremap)
  map('n', '<D-l>', ':MoveHChar(1)<CR>', noremap)
  map('n', '<D-h>', ':MoveHChar(-1)<CR>', noremap)
  map('v', '<D-l>', ':MoveHBlock(1)<CR>', noremap)
  map('v', '<D-h>', ':MoveHBlock(-1)<CR>', noremap)

  -- Copy / Paste via CMD c / v
  map('', '<D-v>', '+p<CR>', noremap) -- CMD + v paste in Normal, Visual, Select, Operator-pending
  map('!', '<D-v>', '<C-R>+', noremap) -- CMD + v paste in Insert and Command-line
  -- map('v', '<D-v>', '<C-R>+', noremap)
  map('v', '<D-c>', '"+y<CR>', noremap) -- CMD + c in visual mode

-- on Linux/Windows use CTRL
else
  map('i', '<C-s>', '<ESC> :update <CR>', noremap) -- exit insert mode and save file
  map('n', '<C-s>', ':update<CR>', noremap) -- save file

  map('n', '<C-Right>', ':tabn<CR>', noremap) -- next tab
  map('n', '<C-Left>', ':tabp<CR>', noremap) -- previous tab
  map('n', '<C-Up>', ':bn!<CR>', noremap) -- next buffer
  map('n', '<C-Down>', ':bp!<CR>', noremap) -- previous buffer

  -- Move lines and blocks per move plugin
  map('n', '<A-j>', ':MoveLine(1)<CR>', noremap)
  map('n', '<A-k>', ':MoveLine(-1)<CR>', noremap)
  map('v', '<A-j>', ':MoveBlock(1)<CR>', noremap)
  map('v', '<A-k>', ':MoveBlock(-1)<CR>', noremap)
  map('n', '<A-l>', ':MoveHChar(1)<CR>', noremap)
  map('n', '<A-h>', ':MoveHChar(-1)<CR>', noremap)
  map('v', '<A-l>', ':MoveHBlock(1)<CR>', noremap)
  map('v', '<A-h>', ':MoveHBlock(-1)<CR>', noremap)

  -- Copy / Paste via CTRL c / v
  map('!', '<C-v>', '<C-R>+', noremap) -- CMD + v paste in Insert and Command-line

end

-- Launch plugins
map('n', '<leader>o', '<cmd>NvimTreeToggle<cr>', { desc = "NvimTree" }) -- toggle NvimTree
map('n', '<leader>a', '<cmd>AerialToggle<cr>', { desc = "Aerial" }) -- toggle Aerial

-- Resize tabs
map('n', '<leader>+', ':vertical resize +5<cr>', { desc = "Vertical resize +5" }) -- increase VSplit
map('n', '<leader>-', ':vertical resize -5<cr>', { desc = "Vertical resize -5" }) -- decrease VSplit
map('n', '<leader>*', ':resize +5<cr>', { desc = "Resize +5" }) -- increase HSplit
map('n', '<leader>_', ':resize -5<cr>', { desc = "Resize -5" }) -- decrease HSplit

-- Tabs
map('n', '<leader>t', '<cmd>tabnew<cr>', { desc = "New Tab" }) -- new tab

-- Buffers
map('n', '<leader>b', '<cmd>BufferDelete hidden<cr>', { desc = "Close unused buffers" }) -- remove buffers not attached to tabs
map('n', '<leader>x', '<cmd>BufferDelete! this<cr>', { desc = "Close current buffer" }) -- close this tab, without closing the split

-- Copy / Paste
map("v", "p", '"_dP', { desc = "Paste without yanking" }) -- Paste over currently selected text without yanking it
map('n', '<leader>p', '<cmd>pu<CR>', { desc = "Paste in next line" }) -- paste line below current text


-- Center search results
map("n", "n", "nzz", noremap)
map("n", "N", "Nzz", noremap)

-- Better indent
map("v", "<", "<gv", noremap) -- selection is not removed after indenting
map("v", ">", ">gv", noremap) -- ""

-- Diagnostics
-- see lsp.lua

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Telescope Find Files" })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = "Telescope Grep" })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = "Telescope Buffers" })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = "Telescope MRU" })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = "Telescope Help" })
map('n', '<leader>fs', '<cmd>Telescope possession list<cr>', { desc = "Telescope Posession" })

-- See `:help telescope.builtin`
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Comment
-- map('n', '<leader>-', '<Plug>(comment_toggle_linewise)', noremap)


-- Workspaces
map('n', '<leader>wn', '<cmd>WorkspacesOpen nvim<CR>', { desc = "Nvim config" })
map('n', '<leader>wr', '<cmd>WorkspacesOpen reascripts<CR>', { desc = "ReaScripts" })
map('n', '<leader>?', '<cmd>Cheatsheet<cr>', { desc = "Cheatsheet" })

-- Yanky
map("n", "p", "<Plug>(YankyPutAfter)", { desc = "Yanky put after" })
map("n", "P", "<Plug>(YankyPutBefore)", { desc = "Yanky put before" })
map("x", "p", "<Plug>(YankyPutAfter)", { desc = "Yanky put after" })
map("x", "P", "<Plug>(YankyPutBefore)", { desc = "Yanky put before" })
map("n", "gp", "<Plug>(YankyGPutAfter)", { desc = "Yanky put after" })
map("n", "gP", "<Plug>(YankyGPutBefore)", { desc = "Yanky put before" })
map("x", "gp", "<Plug>(YankyGPutAfter)", { desc = "Yanky put after" })
map("x", "gP", "<Plug>(YankyGPutBefore)", { desc = "Yanky put before" })
map("n", "<c-n>", "<Plug>(YankyCycleForward)", { desc = "Yanky cycle forward" })
map("n", "<c-p>", "<Plug>(YankyCycleBackward)", { desc = "Yanky cycle backward" })

-- Leap
map("n", "s", "<Plug>(leap-forward)", { desc = "Leap forward" })
map("n", "S", "<Plug>(leap-backward)", { desc = "Leap backward" })
map("o", "z", "<Plug>(leap-forward)", { desc = "Leap forward" })
map("o", "Z", "<Plug>(leap-backward)", { desc = "Leap backward" })
map("o", "x", "<Plug>(leap-forward-x)", { desc = "Leap forward x" })
map("o", "X", "<Plug>(leap-backward-x)", { desc = "Leap backward x" })

