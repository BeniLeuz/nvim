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


-- require("termemulator")
-- require("termbuf").setup({
--
-- })

-- theme for printing white background uncomment when needed
-- vim.cmd("colorscheme polar");



