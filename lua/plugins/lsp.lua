require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.enable("sourcekit")

vim.lsp.config("ts_ls", {
	-- Server-specific settings. See `:help lsp-quickstart`
	settings = {
		implicitprojectconfiguration = {
			checkjs = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("clangd", {
	init_options = {
		fallbackflags = {
			-- "-std=c++23",
			"-i../include/",
			"-i./include/",
		},
	},
})

vim.lsp.config("html", {
	filetypes = { "html", "markdown", "htmldjango", "eruby" },
	settings = {
		html = {
			format = { indentinnerhtml = true },
		},
	},
})

-- latex lsp
vim.lsp.config("texlab", {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-auxdir=build",
					"%f",
				},
				onSave = true,
			},
			forwardSearch = {
				executable = "sioyek",
				args = {
					"--reuse-window",
					"--nofocus",
					"--forward-search-file",
					"%f",
					"--forward-search-line",
					"%l",
					"%p",
				},
			},
		},
	},
})

-- Lsp attach stuff for mostly latex
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		if vim.bo[args.buf].filetype == "tex" then
			vim.keymap.set(
				"n",
				"<leader>pf",
				"<Cmd>LspTexlabForward<CR>",
				{ buffer = args.buf, desc = "LaTeX forward search" }
			)
		end

		-- Automatically setup inverse search in Sioyek when LSP attaches
		vim.defer_fn(function()
			local pdf = vim.fn.expand("%:p:r") .. ".pdf"
			if vim.fn.filereadable(pdf) == 1 then
				vim.fn.jobstart({
					"sioyek",
					"--reuse-window",
					"--execute-command",
					"toggle_synctex",
					"--inverse-search",
					string.format(
						'nvim --server %s --remote-send "<Cmd>edit %%1 | call cursor(%%2, 1)<CR>"',
						vim.v.servername
					),
					pdf,
				}, { detach = true })
			end
		end, 100)
	end,
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
