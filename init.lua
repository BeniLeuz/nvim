local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("vim-remaps")
require("projectionizer")
require("commandwindow")
require("theme")
require("lazy").setup("plugins", {
  change_detection = { notify = false }
})

-- this is only because peb is not a real file. its fake
-- vim.filetype.add({
--   extension = {
--     peb = "htmldjango",
--   },
-- })


-- local function term_codes(str) return vim.api.nvim_replace_termcodes(str, true, false, true) end
--
-- vim.api.nvim_create_autocmd("TermOpen", {
--     callback = function(args)
--     local buf = args.buf
--     local chan = vim.b[buf].terminal_job_id
--     vim.keymap.set('n', '<leader>t',
--       function()
--         vim.fn.chansend(chan, term_codes('<C-a>'))
--         vim.fn.chansend(chan, term_codes('<C-f><C-f>'))
--         vim.fn.chansend(chan, term_codes('<C-a>'))
--       end, { buffer = buf })
--   end
-- })

-- require("termbuf").setup({
-- })

-- theme for printing white background uncomment when needed
-- vim.cmd("colorscheme polar");
