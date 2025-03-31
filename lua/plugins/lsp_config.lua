return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "ruby_lsp",
          "ts_ls",
          "html"
        }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = capabilities
          })
        end,
        ["clangd"] = function()
          lspconfig.clangd.setup {
            capabilities = capabilities,
            init_options = {
              fallbackFlags = {
                "-I../include/",
                "-I./include/",
              }
            },
            filetypes = {
              'c'
            }
          }
        end,

        -- different fallbackflags for c and c++ therefore 2 setup functions for clang
        ["clangd"] = function()
          lspconfig.clangd.setup {
            capabilities = capabilities,
            init_options = {
              fallbackFlags = {
                "-std=c++23",
                "-I../include/",
                "-I./include/",
              }
            },
            filetypes = {
              'cpp'
            }
          }
        end,
        ["html"] = function()
          lspconfig.html.setup {
            capabilities = capabilities,
            filetypes = { 'html', 'md' },
            settings = {
              html = { format = { indentInnerHtml = true } }
            }
          }
        end,
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
