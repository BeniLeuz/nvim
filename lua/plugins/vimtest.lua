return {
  "vim-test/vim-test",
  init = function()
    vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>")
    vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>")

    vim.g['test#java#gradletest#options'] = '--info'
    vim.g['test#runner_commands'] = { "RSpec", "MavenTest", "GradleTest" }
  end,
}
