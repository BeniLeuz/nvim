return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },
  tag = 'v1.0.0',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { 
      preset = 'enter',
      ["<Tab>"] = { 'select_next' },
    },
    completion = {
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = false
        }
      }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },

      providers = {
        snippets = {
          opts = {
            extended_filetypes = {
              svelte = { "html" }
            },
            ignored_filetypes = {},
            get_filetype = function(context)
              return vim.bo.filetype
            end
          },
        },
      }
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

  },
  opts_extend = { "sources.default" }
}
