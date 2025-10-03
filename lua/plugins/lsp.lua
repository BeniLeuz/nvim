require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.enable('sourcekit')

vim.lsp.config("ts_ls", {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    implicitprojectconfiguration = {
      checkjs = true,
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
})

vim.lsp.config("clangd", {
  init_options = {
    fallbackflags = {
      -- "-std=c++23",
      "-i../include/",
      "-i./include/",
    }
  },
})

vim.lsp.config("html", {
  filetypes = { 'html', 'markdown', 'htmldjango' },
  settings = {
    html = {
      format = { indentinnerhtml = true },
    }
  }
})


vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
