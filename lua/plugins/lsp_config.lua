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
          "html",
        }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- for nvim-jdtls workspace clearing:
      -- rm -rf ~/.cache/jdtls/* or
      -- rm -rf ~/.local/share/nvim/jdtls-workspace/*
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = capabilities
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup {
            capabilities = capabilities,
            settings = {
              implicitProjectConfiguration = {
                checkJs = true,
              },
            },
          }
        end,
        ["clangd"] = function()
          lspconfig.clangd.setup {
            capabilities = capabilities,
            init_options = {
              fallbackFlags = {
                -- this ruins c filetype and i dont know an easier way to fix this than just using .clangd file in root
                -- for this specific flag in c++ projects
                "-std=c++23",
                "-I../include/",
                "-I./include/",
              }
            },
          }
        end,
        ["html"] = function()
          lspconfig.html.setup {
            capabilities = capabilities,
            filetypes = { 'html', 'md', 'htmldjango' },
            settings = {
              html = {
                format = { indentInnerHtml = true },
              }
            }
          }
        end,
      })

      lspconfig.sourcekit.setup {
        capabilities = capabilities
      }

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
