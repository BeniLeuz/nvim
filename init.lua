vim.pack.add({
  { src = "https://github.com/habamax/vim-polar" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon",                     version = "harpoon2" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp",                         version = "v1.0.0" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/chomosuke/term-edit.nvim", version = "v1.4.0" },
  -- neotest
  -- INFO: needs to be ran to download junit console
  -- :NeotestJava setup
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
  { src = "https://github.com/alfaix/neotest-gtest" },
  { src = "https://github.com/mfussenegger/nvim-jdtls" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/rcasia/neotest-java" },
  { src = "https://github.com/nvim-neotest/neotest" },
})

-- vim.o.shell = '/bin/bash -l'
-- vim.g.clipboard = {
--     name = 'iTerm2 copy',
--     copy = {
--         ['+'] = {'bash', '-c', '~/.iterm2/it2copy>$SSH_TTY'},
--         ['*'] = {'bash', '-c', '~/.iterm2/it2copy>$SSH_TTY'}
--     },
--     paste = {['+'] = 'true', ['*'] = 'true'}
-- }

-- add this to .gitconfig for git d -d main working as expected
-- [diff]
--   tool = nvim_difftool
-- [difftool "nvim_difftool"]
--     cmd = nvim -c \"set diff\" -c \"silent! DiffTool $LOCAL $REMOTE\"
vim.cmd("packadd nvim.difftool")

require("vim-options")
require("vim-remaps")
require("theme")
require("projectionizer")
require("commandwindow")
-- currently broken in nvim 12 not sure why just rewrite this XDDD
-- require("plugins.editable_term")
require("plugins.harpoon")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.oil")
require("plugins.autocomplete")
require("plugins.lsp")
require("plugins.term-edit")


require("plugins.neotest")

-- require("termbuf").setup({})



-- for printing
-- vim.cmd("colorscheme polar");
