return {

  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'rubocop',
          'ruby_ls',
          'tsserver',
          'cssls',
          'solargraph',
          'clangd',
          'html',
          'jdtls',
          'omnisharp',
          'gopls',
          'hls',
          'groovyls',
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.groovyls.setup {
        cmd = { "groovy-language-server" },
      }

      lspconfig.gopls.setup {
        capabilities = capabilities
      }

      lspconfig.omnisharp.setup {
        capabilities = capabilities,
        cmd = { 'dotnet', vim.fn.stdpath 'data' .. '/mason/packages/omnisharp/libexec/OmniSharp.dll' },
        enable_import_completion = true,
        organize_imports_on_format = true,
        enable_roslyn_analyzers = true,
        root_dir = function()
          return vim.loop.cwd() -- current working directory
        end,
      }

      lspconfig.html.setup {
        capabilities = capabilities,
        filetypes = { 'html', 'md' },
      }

      lspconfig.hls.setup {
        capabilities = capabilities,
      }

      lspconfig.clangd.setup {
        capabilities = capabilities,
      }

      lspconfig.ruby_ls.setup {
        capabilities = capabilities,
        filetypes = { 'ruby' },
      }

      lspconfig.solargraph.setup {
        capabilities = capabilities,
        filetypes = { 'ruby', 'eruby' },
      }

      lspconfig.jdtls.setup {
        capabilities = capabilities,
      }

      -- not actually needed cause solargraph crazy fr
      --      lspconfig.rubocop.setup {
      --        capabilities = capabilities,
      --      }

      lspconfig.tsserver.setup {
        capabilities = capabilities,
      }

      lspconfig.cssls.setup {
        capabilities = capabilities,
      }

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
