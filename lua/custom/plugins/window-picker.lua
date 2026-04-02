return {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require('window-picker').setup {
      hint = 'floating-big-letter',
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        bo = {
          filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
          buftype = { 'terminal', 'quickfix' },
        },
      },
    }

    -- Keymap to pick a window
    vim.keymap.set('n', '<leader>wp', function()
      local picked_window_id = require('window-picker').pick_window()
      if picked_window_id then
        vim.api.nvim_set_current_win(picked_window_id)
      end
    end, { desc = '[W]indow [P]ick' })
  end,
}
