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
-- diff all against upstream in TABS
-- vim.keymap.set('n', '<leader>du', ':Git difftool -y @{upstream}<CR>')

local function open_qf_diff()
  vim.cmd('.cc')
  vim.cmd('Gvdiffsplit @{upstream}')
  vim.cmd('copen 10')
  vim.cmd('wincmd k')
  vim.cmd('wincmd l')
end

-- diff with a double view and quickfix
vim.keymap.set('n', '<leader>du', function()
  vim.cmd('Git difftool @{upstream}')
  open_qf_diff()
end)


-- just so we dont reset on subsequent autocmds
local qf_mapping_set = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(args)
    if qf_mapping_set then return end
    qf_mapping_set = true

    vim.keymap.set('n', '<CR>', function()
      local qf_list = vim.fn.getqflist({ title = 0 })       -- Get current list each time

      if not (qf_list.title and string.match(qf_list.title, 'difftool @')) then
        vim.cmd('.cc')
        return
      end

      pcall(function()
        vim.cmd('windo if &filetype != "qf" | execute "close" | endif')
        open_qf_diff()
      end)
    end, { buffer = args.buf })
  end
})

vim.keymap.set('n', '[q', function()
  local qf_list = vim.fn.getqflist({ title = 0 })
  if qf_list.title and string.match(qf_list.title, 'difftool @') then
    local _, _ = pcall(function()
      vim.cmd('cprevious')
      vim.cmd('windo if &filetype != "qf" | execute "close" | endif')
      open_qf_diff()
    end)
  else
    pcall(vim.cmd, 'cprevious')
  end
end)

vim.keymap.set('n', ']q', function()
  local qf_list = vim.fn.getqflist({ title = 0 })
  if qf_list.title and string.match(qf_list.title, 'difftool @') then
    local ok, err = pcall(function()
      vim.cmd('cnext')
      vim.cmd('windo if &filetype != "qf" | execute "close" | endif')
      open_qf_diff()
    end)
  else
    pcall(vim.cmd, 'cnext')
  end
end)
