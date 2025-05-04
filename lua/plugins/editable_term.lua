return {
  'xb-bx/editable-term.nvim',
  config = function()
    -- this might be the best plugin i have ever seen in my entire life, neovim, plesae upstream this
    local editableterm = require('editable-term')
    editableterm.setup({
      promts = {
        ['.*[$#][ ]?'] = {}
      },
    })
  end,
}
