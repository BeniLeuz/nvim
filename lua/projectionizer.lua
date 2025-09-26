local function term_intercept_cr()
  local line = vim.api.nvim_get_current_line()

  local s, e = line:find("nvim ")

  if not s then
    vim.env.CLOSE_UNNEST = 0
  else
    vim.env.CLOSE_UNNEST = 1
  end

  return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
end

vim.keymap.set("t", "<CR>", term_intercept_cr, { expr = true, noremap = true })

if not vim.env.NVIM then
  return
end

local _, parent_chan = pcall(vim.fn.sockconnect, "pipe", vim.env.NVIM, { rpc = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.rpcrequest(parent_chan, "nvim_command", "tabnew " .. vim.api.nvim_buf_get_name(0))
    vim.rpcrequest(parent_chan, "nvim_command", "tcd " .. vim.fn.getcwd())

    local close = vim.rpcrequest(parent_chan, "nvim_eval", 'getenv("CLOSE_UNNEST")')
    if close == "1" then
      -- needs to be done since if we ever do nvim and then into nvim . it might still try to use the old ones so clear them!
      vim.rpcrequest(parent_chan, "nvim_command", "augroup UnnestAutoClose | autocmd! | augroup END")
      vim.cmd(":q!")
      return
    end

    -- create/clear the group first
    vim.rpcrequest(parent_chan, "nvim_command", "augroup UnnestAutoClose | autocmd! | augroup END")

    -- add the new TabClosed autocmd
    local tabpagenr = vim.rpcrequest(parent_chan, "nvim_call_function", "tabpagenr", {})
    local child_server = vim.v.servername

    local cmd = string.format([[
augroup UnnestAutoClose
  autocmd TabClosed * if expand("<afile>") == "%d"
    call rpcnotify(sockconnect('pipe', '%s', #{ rpc: v:true }), 'nvim_command', 'quitall!')
  endif
augroup END
]], tabpagenr, child_server)

    vim.rpcrequest(parent_chan, "nvim_command", cmd)
  end
})
