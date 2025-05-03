local M = {}

function executeModifiedCommand()
  -- Get the current line (command)
  local cmd = vim.fn.getline(".")

  -- Modify the command (example: add a comment)
  local modified_cmd = "new tmp | r " .. cmd

  -- For debugging
  print("Original command: " .. cmd)
  print("Modified command: " .. modified_cmd)

  -- Exit insert mode and quit the command-line window
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>:quit<CR>", true, false, true),
    "n", -- non-recursive
    false
  )

  -- Schedule command execution after window closes
  vim.schedule(function()
    -- If the previous buffer exists, wipe it
    if M.previous_buffer then
      vim.api.nvim_buf_delete(M.previous_buffer, { force = true }) -- Delete the previous buffer
    end

    vim.cmd(modified_cmd)
    vim.cmd("setlocal buftype=nofile") -- Treat the buffer as 'nofile'
    vim.cmd("setlocal filetype=term")
    -- add command to history lol
    vim.fn.histadd(":", cmd)
    -- set current buffer as previous buffer
    M.previous_buffer = vim.api.nvim_get_current_buf()
  end)
end

-- When entering command window, remap Enter key
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = ":",
  callback = function()
    -- Create a local mapping for the command window
    vim.keymap.set({ 'n', 'i', 'v' }, '<CR>',
      [[<cmd>lua executeModifiedCommand()<CR>]],
      { buffer = 0 })

    print("Command window entered, CR remapped")
  end
})
