if not vim.env.NVIM then
	return
end

local _, parent_chan = pcall(vim.fn.sockconnect, "pipe", vim.env.NVIM, { rpc = true })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
    vim.rpcrequest(parent_chan, "nvim_command", "tabnew " .. vim.api.nvim_buf_get_name(0))
    vim.rpcrequest(parent_chan, "nvim_command", "tcd " .. vim.fn.getcwd())
    vim.cmd(":q!")
  end
})

-- if i EVER want to have git rebase -i working too while having my implementation of nvim unnest
-- with unnest.nvim this stuff needs to be done setuff and sso one basldkbfalshfdsalkjfhsd
-- local function term_intercept_cr()
--   local line = vim.api.nvim_get_current_line()
--
--   -- open inside new project only if found with a space. I only open projects with nvim .
--   local s, e = line:find("nvim ")
--
--   if not s then
--     return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
--   end
--
--   -- extract the argument after "nvim"
--   local arg = line:sub(e + 1):gsub("^%s+", "") -- e.g., "." or "../file"
--
--   -- get terminal cwd
--   -- TODO: this does not work yet lol path is f'd up
--   local bufnr = vim.api.nvim_get_current_buf()
--   local term_name = vim.api.nvim_buf_get_name(bufnr)
--   local cwd = term_name:match("^term://([^/]+)//") or vim.loop.cwd()
--   local full_path = vim.fn.fnamemodify(cwd .. "/" .. arg, ":p")
--
--   vim.schedule(function()
--     vim.cmd("tabnew " .. full_path)
--   end)
--
--   -- clear the line after opening new project :)
--   -- does this even happen after or will it just fucking send control c to the tabnew? i think it will lol
--   return vim.api.nvim_replace_termcodes("<C-C>", true, false, true)
-- end

-- vim.keymap.set("t", "<CR>", term_intercept_cr, { expr = true, noremap = true })
