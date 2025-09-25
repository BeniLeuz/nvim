-- vim remaps
vim.keymap.set('n', '<Leader>pv', vim.cmd.Ex)

-- moving lines in visual mode, nice
-- remaps for staying in the middle on ctrl d/u for halfway jumps
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- search terms stay in the middle
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

-- copy logics
-- vim.keymap.set('n', 'd', "\"_d")
-- vim.keymap.set('x', 'p', "\"_dP")
-- dont copy on delete
-- vim.keymap.set('v', 'd', "\"_d")
-- vim.keymap.set('n', 'dd', "\"_dd")
-- dont copy on diw etc
-- vim.keymap.set('n', 'd', "\"_d")
-- dont copy on ciw etc
-- this breaks ciw from editable term btw lol
-- vim.keymap.set('n', 'c', "\"_c")

-- for system clipboard use leader copy
vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")


-- go out of terminal mode easy access
vim.keymap.set('t', '<C-f>', '<C-\\><C-n>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- command line window remap magic. ctrl-f being a toggle now
vim.keymap.set({ 'i', 'v', 'n' }, '<C-f>', function()
  local keys = vim.api.nvim_replace_termcodes('<Esc><C-c>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, { noremap = true, silent = true })

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


-- tabbing around projects like this is emacs fr
vim.keymap.set("n", "<M-1>", "<Cmd>tabn 1<CR>")
vim.keymap.set("n", "<M-2>", "<Cmd>tabn 2<CR>")
vim.keymap.set("n", "<M-3>", "<Cmd>tabn 3<CR>")
vim.keymap.set("n", "<M-4>", "<Cmd>tabn 4<CR>")
