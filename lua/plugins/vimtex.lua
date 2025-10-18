-- infos:
-- activate synctex with f4
-- using double right click will go to the locaion in nvim in sioyek
-- sioyek has a nofocus bug that is fixed now in: https://github.com/ahrm/sioyek/issues/1483
vim.g.vimtex_view_automatic = 0
-- vim.g.vimtex_view_method = "sioyek"
-- vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_general_viewer = "sioyek"

vim.g.vimtex_view_general_options = string.format([[--reuse-window --nofocus --inverse-search "%s --headless -c \"VimtexInverseSearch %%2 '%%1'\"" --forward-search-file @tex --forward-search-line @line @pdf
]], vim.fn.exepath("nvim"))

vim.g.vimtex_compiler_latexmk = {
	build_dir = "build", -- aux files go here
	options = {
		"-pdf",
		"-interaction=nonstopmode",
		"-synctex=1",
		"-aux-directory=build",
	},
}

-- Forward search on cursor movement (with debouncing to avoid spam)
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  pattern = "*.tex",
  callback = function()
    local line = vim.fn.line(".")
    if line == last_line then
      return
    end
    last_line = line

    if timer then
      vim.fn.timer_stop(timer)
    end
    timer = vim.fn.timer_start(200, function()
      vim.cmd("VimtexView")
    end)
  end,
})



-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "VimtexEventCompileSuccess",
-- 	callback = function()
-- 		local pdf = vim.fn.expand("%:p:r") .. ".pdf"
--
-- 		vim.fn.jobstart({
-- 			"/Applications/sioyek.app/Contents/MacOS/sioyek", -- Absolute path
-- 			"--reuse-window",
-- 			"--nofocus",
-- 			"--execute-command",
-- 			"reload_no_flicker",
-- 			pdf,
-- 		}, { detach = true })
-- 	end,
-- })

-- -- Flicker-free reload on successful compilation
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "VimtexEventCompileSuccess",
-- 	callback = function()
-- 		local pdf = vim.fn.expand("%:p:r") .. ".pdf"
--
-- 		vim.fn.jobstart({
-- 			"sioyek",
-- 			"--reuse-window",
-- 			"--nofocus",
-- 			"--execute-command",
-- 			"reload_no_flicker",
-- 			pdf,
-- 		}, { detach = true })
-- 	end,
-- })
--
-- -- Refocus iTerm2 after inverse search (clicking in Sioyek)
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "VimtexEventViewReverse",
-- 	callback = function()
-- 		vim.fn.system([[osascript -e 'tell application "iTerm2" to activate']])
-- 	end,
-- })
--
-- vim.keymap.set('n', '<leader>lv', function()
-- 	local file = vim.fn.expand("%:p")
-- 	local line = vim.fn.line(".")
-- 	local pdf = vim.fn.expand("%:p:r") .. ".pdf"
--
-- 	vim.fn.jobstart({
-- 		"sioyek",
-- 		"--reuse-window",
-- 		"--nofocus",
-- 		"--forward-search-file",
-- 		file,
-- 		"--forward-search-line",
-- 		tostring(line),
-- 		pdf,
-- 	}, { detach = true })
-- end, { buffer = true, desc = "VimTeX forward search" })
