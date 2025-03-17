-- vim remaps
vim.keymap.set( 'n' , '<Leader>pv', vim.cmd.Ex)


-- moving lines in visual mode, nice
vim.keymap.set( 'v' , 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set( 'v' , 'K', ":m '<-2<CR>gv=gv")


-- remaps for staying in the middle on ctrl d/u for halfway jumps
vim.keymap.set( 'n' , '<C-d>', "<C-d>zz")
vim.keymap.set( 'n' , '<C-u>', "<C-u>zz")

-- search terms stay in the middle
vim.keymap.set( 'n' , 'n', "nzzzv")
vim.keymap.set( 'n' , 'N', "Nzzzv")


-- keep that pasting magic when using leader p to paste something over the other word
vim.keymap.set( 'x' , '<leader>p', "\"_dP")
-- for system clipboard use leader copy 
-- TODO: Check if maybe it makes sense to use ctrl c and leader c for copying rather thanusing yank
vim.keymap.set( 'n' , '<leader>y', "\"+y")
vim.keymap.set( 'v' , '<leader>y', "\"+y")


-- make terminal mode exitable by using ctrl z this might interfere with the standard ctrl z usage of terminal
-- but im just gonna try it out for now and see it it works nice since ctrl z is easily rememberable.
vim.keymap.set('t', '<C-z>', '<C-\\><C-n>')


-- remap esc to ctrl-c
vim.keymap.set( 'i' , '<C-c>', "<Esc>")
-- Literal search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- showing up diagnostics with newlines in a floating window
vim.keymap.set({"n"}, "<leader>cd", vim.diagnostic.open_float)
