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
                "-std=c++23",
                "-I../include/",
                "-I./include/",
              }
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
        -- old configs if i need again
        --
        --
        -- lspconfig.lua_ls.setup {
        --   capabilities = capabilities,
        -- }
        --
        -- lspconfig.intelephense.setup({
        --   capabilities = capabilities,
        -- })
        --
        --
        -- lspconfig.hls.setup {
        --   capabilities = capabilities,
        -- }
        --
        --
        -- lspconfig.ruby_lsp.setup {
        --   capabilities = capabilities,
        --   filetypes = { 'ruby' },
        -- }
        --
        -- lspconfig.solargraph.setup {
        --   capabilities = capabilities,
        --   filetypes = { 'ruby', 'eruby' },
        -- }
        --
        -- lspconfig.jdtls.setup {
        --   capabilities = capabilities,
        -- }
        --
        -- -- not actually needed cause solargraph crazy fr
        -- --      lspconfig.rubocop.setup {
        -- --        capabilities = capabilities,
        -- --      }
        --
        -- lspconfig.ts_ls.setup {
        --   capabilities = capabilities,
        -- }
        --
        -- lspconfig.cssls.setup {
        --   capabilities = capabilities,
        -- }
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
