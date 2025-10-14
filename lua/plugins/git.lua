-- workflow if i use this
-- leader gs open window
-- literal = = togglin the inline diff
-- i = jump through hunks and auto open top down
-- s = stage
-- u = unstage
-- dv = diffview for a inline change etc
-- I = interactive hunk by hunk adding removing etc
-- cc = commit
-- X = delete change

--checking
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- git diff all and git diff head all
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.keymap.set("n", "<leader>da", ":Git difftool -y<CR>", { buffer = true, noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dh", ":Git difftool -y HEAD<CR>", { buffer = true, noremap = true, silent = true })
    vim.keymap.set('n', '<leader>du', function()
      local branch = vim.fn.FugitiveHead()
      vim.cmd('Git difftool -y ' .. '@{upstream}..' .. branch)
    end, { desc = 'Git diff against upstream' })
  end,
})
