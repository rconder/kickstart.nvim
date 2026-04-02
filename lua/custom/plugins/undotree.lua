return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('undotree').setup()
  end,
  keys = {
    {
      '<leader>u',
      '<cmd>lua require("undotree").toggle()<CR>',
      desc = 'Toggle UndoTree',
    },
  },
}
