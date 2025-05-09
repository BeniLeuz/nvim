local function start_emulated_terminal()
  local buf = vim.api.nvim_create_buf(false, true)
  local prompt_prefix = "❯ "
  local prompt_line = 0
  local job_id

  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  vim.api.nvim_win_set_buf(0, buf)

  local function append_lines(data)
    if not data then return end
    for _, line in ipairs(data) do
      if line ~= "" then
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
      end
    end
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { prompt_prefix })
    prompt_line = vim.api.nvim_buf_line_count(buf)
    vim.api.nvim_win_set_cursor(0, { prompt_line, #prompt_prefix })
  end

  function _G.send_input()
    local line = vim.api.nvim_buf_get_lines(buf, prompt_line - 1, prompt_line, false)[1]
    local input = line:sub(#prompt_prefix + 1)
    vim.api.nvim_buf_set_lines(buf, prompt_line - 1, prompt_line, false, { line }) -- freeze
    vim.fn.chansend(job_id, input .. "\n")
  end

  vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', "<Cmd>lua send_input()<CR>", { noremap = true, silent = true })

  job_id = vim.fn.jobstart({ "bash" }, {
    pty = true, -- enables interactivity
    on_stdout = function(_, data)
      if data then
        append_lines(data)
      end
    end,
    on_stderr = function(_, data)
      append_lines(data)
    end,
    on_exit = function(_, code)
      append_lines({ ">>> exited with code " .. code })
    end,
  })

  -- Insert the initial prompt
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { prompt_prefix })
  prompt_line = vim.api.nvim_buf_line_count(buf)
end

start_emulated_terminal()

