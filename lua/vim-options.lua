-- in here come the keymaps and vim options that aree not plugin specific. Plugin specific keymaps can be found in their respective lua file under plugins/
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.number = true
vim.o.relativenumber = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '



vim.opt.statusline = "%#StatusLine#%F %#StatusModified#%m %#StatusRO#%r %=%{v:lua.macro_recording()}"
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.cmdheight = 0



-- info: packadd termdebug
-- :Termdebug for vim gdb debugging yo

vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.fillchars='eob: '
vim.o.winborder = 'rounded'
-- needed for treesitter to highlight properly
vim.o.termguicolors = true
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve-t:ver25,r-cr-o:hor20"
-- add when ready without tooltips
vim.g.netrw_banner = 0
-- auto shot diagnostics for error but rest show with <leader>cd for open_float()
vim.diagnostic.config({
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR
  },
})
