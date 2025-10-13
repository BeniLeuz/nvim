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

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
