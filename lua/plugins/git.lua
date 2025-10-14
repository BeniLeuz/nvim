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

-- overview
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
-- diff unstaged against working dir
-- vim.keymap.set("n", "<leader>da", ":Git difftool -y<CR>")
-- diff staged against head
-- vim.keymap.set("n", "<leader>dh", ":Git difftool -y HEAD<CR>")
-- diff all against upstream
vim.keymap.set('n', '<leader>du', ':Git difftool -y @{upstream}<CR>')
