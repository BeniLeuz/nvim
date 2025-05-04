return {
  'xb-bx/editable-term.nvim',
  config = function()
    local editableterm = require('editable-term')
    editableterm.setup({
      promts = {
        ['.*[$#%%][ ]?'] = {}
      },
    })
  end,
}
