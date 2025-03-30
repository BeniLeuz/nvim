return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },

  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "^.git/" },
        border = false,
        hidden = true
      },
      pickers = {
        find_files = {
          hidden = true
        },
      },
    }

    local builtin = require("telescope.builtin")
    require("telescope").load_extension("fzf")

    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  end
}
