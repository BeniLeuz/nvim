return {
  'saghen/blink.cmp', -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },
  tag = 'v1.0.0',
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_next()
          end
        end,
        'fallback'
      },
    },
    completion = {
      trigger = {
        show_in_snippet = false,
      },
      documentation = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false
        }
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- for not showing window when backspacing to empty line
      min_keyword_length = 1,
      providers = {
        snippets = {
          opts = {
            extended_filetypes = {
              svelte = { "html" },
              eruby = { "html" }
            },
            ignored_filetypes = {},
          },
        },
      }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
