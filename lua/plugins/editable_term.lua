local editableterm = require('editable-term')
editableterm.setup({
  promts = {
    ['.*[$#%%][ ]'] = {},
    ["%(%gdb%)[ ]"] = {},
    ["^ghci>%s"] = {}
  },
})
