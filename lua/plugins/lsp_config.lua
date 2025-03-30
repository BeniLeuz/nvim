return {
  {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rubocop",
					"ruby_lsp",
					"ts_ls",
					"cssls",
					"solargraph",
					"clangd",
					"html",
					"jdtls",
					"hls",
          "intelephense",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp"
    },
		config = function()
			local lspconfig = require("lspconfig")
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

			lspconfig.intelephense.setup({
				capabilities = capabilities,
			})

      lspconfig.html.setup {
        capabilities = capabilities,
        filetypes = { 'html', 'md' },
        settings = {
          html = { format = { indentInnerHtml = true } }
        }
      }

      lspconfig.hls.setup {
        capabilities = capabilities,
      }

      lspconfig.clangd.setup {
        capabilities = capabilities,
        init_options = {
          fallbackFlags = {
            "-std=c++23",
            "-I../include/",
            "-I./include/",
          }
        }
      }

      lspconfig.ruby_lsp.setup {
        capabilities = capabilities,
        filetypes = { 'ruby' },
      }

      lspconfig.solargraph.setup {
        capabilities = capabilities,
        filetypes = { 'ruby', 'eruby' },
      }

      lspconfig.jdtls.setup {
        capabilities = capabilities,
      }

      -- not actually needed cause solargraph crazy fr
      --      lspconfig.rubocop.setup {
      --        capabilities = capabilities,
      --      }

      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.cssls.setup {
        capabilities = capabilities,
      }

      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({ border = 'single' })
      end)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
