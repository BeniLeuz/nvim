return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.checkstyle.with({
        --   extra_args = { "-c", "$ROOT/src/main/config/swc_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        -- }),
        -- null_ls.builtins.formatting.checkstyle,
        -- null_ls.builtins.formatting.htmlbeautifier
      }
    })

    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
  end
}
