-- vim remaps
vim.keymap.set('n', '<Leader>pv', vim.cmd.Ex)


-- moving lines in visual mode, nice
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")


-- remaps for staying in the middle on ctrl d/u for halfway jumps
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")

-- search terms stay in the middle
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")


-- keep that pasting magic when using leader p to paste something over the other word
vim.keymap.set('x', '<leader>p', "\"_dP")
-- for system clipboard use leader copy
-- TODO: Check if maybe it makes sense to use ctrl c and leader c for copying rather thanusing yank
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")


-- go out of terminal mode easy access
vim.keymap.set('t', '<C-f>', '<C-\\><C-n>')

-- this makes it so ctrl f can be used for command line window going into it and out of it
vim.keymap.set({ 'i', 'v', 'n' }, '<C-f>', "<C-c>")

-- command line window only tbh
-- vim.keymap.set('n', ':', function()
--   local buftype = vim.bo.buftype
--   if buftype == 'prompt' or buftype == 'nofile' then
--     return
--   end
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':<C-f>A', true, true, true), 'n', false)
-- end, {
--   noremap = true,                          -- Prevent recursive mapping of ':'
--   silent = true,                           -- Don't echo the simulated keys
--   desc = "Always open CmdWin+Insert for :" -- Description for :Telescope keymaps
-- })

vim.keymap.set('i', '<C-c>', "<Esc>")
vim.keymap.set('v', '<C-c>', "<Esc>")
vim.keymap.set('s', '<C-c>', "<Esc>")

-- Literal search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- showing up diagnostics with newlines in a floating window
vim.keymap.set({ "n" }, "<leader>cd", vim.diagnostic.open_float)
