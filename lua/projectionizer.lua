-- makes "nvim" open unnested in terminal and open it in new tab in parent
-- used for opening multiple projects in the same nvim instance
-- to not break the nice unnested.nvim plugin i just do it on parent and intercept carriage return when necessary
-- unlike unnest i know exaactly when i want to change behavior and nvim will open
-- in unnest you can not close child instance on git rebase -i therefore this would break it if added into unnest to
-- close children after opening in the parent since i dont have context on how tf it opened nvim in vimenter of the child.



-- vimenter mache depending if config file is set to unnest and close we close this nvim after tabnew on parent
-- otherwise do nothing
if not vim.env.NVIM then
	return
end

local _, parent_chan = pcall(vim.fn.sockconnect, "pipe", vim.env.NVIM, { rpc = true })

if not parent_chan or parent_chan == 0 then
	io.stderr:write("Nvim failed to connect to parent")
	vim.cmd("qall!")
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
    vim.rpcrequest(parent_chan, "nvim_command", "tabnew " .. vim.api.nvim_buf_get_name(0))
    vim.rpcrequest(parent_chan, "nvim_command", "tcd " .. vim.fn.getcwd())
    vim.cmd(":q!")
  end
})


local function term_intercept_cr()
  local line = vim.api.nvim_get_current_line()

  -- open inside new project only if found with a space. I only open projects with nvim .
  local s, e = line:find("nvim ")

  if not s then
    return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  end

  -- extract the argument after "nvim"
  local arg = line:sub(e + 1):gsub("^%s+", "") -- e.g., "." or "../file"

  -- get terminal cwd
  -- TODO: this does not work yet lol path is f'd up
  local bufnr = vim.api.nvim_get_current_buf()
  local term_name = vim.api.nvim_buf_get_name(bufnr)
  local cwd = term_name:match("^term://([^/]+)//") or vim.loop.cwd()
  local full_path = vim.fn.fnamemodify(cwd .. "/" .. arg, ":p")

  vim.schedule(function()
    vim.cmd("tabnew " .. full_path)
  end)

  -- clear the line after opening new project :)
  -- does this even happen after or will it just fucking send control c to the tabnew? i think it will lol
  return vim.api.nvim_replace_termcodes("<C-C>", true, false, true)
end

-- vim.keymap.set("t", "<CR>", term_intercept_cr, { expr = true, noremap = true })
