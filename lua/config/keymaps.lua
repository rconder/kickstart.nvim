-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>wq', '<cmd>q<CR>', { desc = 'Save and quit file' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open the file explorer with
vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<CR>', { desc = 'Toggle [P]roject [V]iewer' })

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Hide diagnostics by default
  virtual_text = false,
  virtual_lines = false,
  signs = false,

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

-- Toggle diagnostics visibility
local diagnostics_visible = false
vim.keymap.set('n', '<leader>te', function()
  diagnostics_visible = not diagnostics_visible
  vim.diagnostic.config {
    virtual_text = diagnostics_visible,
    signs = diagnostics_visible,
  }
  if diagnostics_visible then
    print 'Diagnostics enabled'
  else
    print 'Diagnostics hidden'
  end
end, { desc = '[T]oggle [E]rrors and warnings' })

vim.keymap.set('n', '<leader>fq', function()
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  local current_buf = vim.fn.bufnr '%'

  -- Filter out the current buffer
  local other_buffers = vim.tbl_filter(function(buf) return buf.bufnr ~= current_buf end, buffers)

  if #other_buffers > 0 then
    -- There are other buffers, switch to the most recent one
    vim.cmd 'bprevious'
    -- Delete the buffer we just left
    vim.cmd('bdelete ' .. current_buf)
  else
    -- No other buffers, delete current and open neo-tree
    vim.cmd 'bdelete'
    vim.cmd 'Neotree show'
  end
end, { desc = '[F]ile [Q]uit - Delete buffer and switch or open neo-tree' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Search for symbols/functions in current file
vim.keymap.set('n', '<leader>so', function() require('telescope.builtin').lsp_document_symbols() end, { desc = 'Search outline (symbols in file)' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
