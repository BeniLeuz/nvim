local function create_terminal_emulator(command)
  -- Create a new empty buffer (non-terminal, no file)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf) -- Switch to the new buffer

  -- Set the buffer's options
  vim.bo.buftype = "nofile" -- It will not be tied to a file
  vim.bo.bufhidden = "hide" -- Hide the buffer when abandoned
  vim.bo.swapfile = false   -- Disable swapfile for this buffer

  -- Start the job (shell in this case)
  local job_id = vim.fn.jobstart(command, {
    on_stdout = function(_, data)
      -- Capture stdout from the job and append it to the buffer
      local lines = vim.fn.split(vim.fn.join(data, "\n"), "\n")
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
    end,
    on_stderr = function(_, data)
      -- Capture stderr from the job (optional)
      local lines = vim.fn.split(vim.fn.join(data, "\n"), "\n")
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
    end,
    on_exit = function(_, code, _)
      -- Handle job exit (optional)
      print("Job exited with code: " .. code)
    end,
  })
  local function capture_user_input(buf, job_id)
    -- Attach to the buffer to capture changes in insert mode
    vim.api.nvim_buf_attach(buf, false, {
      on_lines = function(_, _, first_line, last_line, lines)
        -- You may not need `lines` directly anymore.
        -- But if we need to capture specific lines, we can do so.

        -- In the on_lines callback, lines may be an argument like `"lines"`, not the table of lines.
        -- The real user input (lines) would have been captured by the buffer change mechanism.

        -- Debugging output to understand what we're getting
        print("on_lines callback triggered!")
        print("First line: " .. first_line .. ", Last line: " .. last_line)

        -- Now let's capture the content of the buffer for the changed lines
        local content = vim.api.nvim_buf_get_lines(buf, first_line, last_line + 1, false)

        -- Join the content into one string to send to the job
        local input = table.concat(content, "\n")

        -- Send the input back to the job
        vim.fn.chansend(job_id, "ls" .. "\n")
      end,
    })
  end
  -- Example usage (within the create_terminal_emulator function):
  capture_user_input(buf, job_id)
end

-- Example: Start a bash shell
create_terminal_emulator("bash")
