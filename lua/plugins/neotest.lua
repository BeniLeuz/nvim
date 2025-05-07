return {
  {
    "rcasia/neotest-java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    -- INFO: needs to be ran to download junit console
    -- config = function()
    --   vim.cmd("NeotestJava setup")
    -- end
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local neotest = require("neotest")

      -- run nearest
      vim.keymap.set("n", "<leader>nn", function()
        neotest.run.run()
      end, { desc = "run current test" })

      -- run file
      vim.keymap.set("n", "<leader>nf", function()
        neotest.run.run(vim.fn.expand('%'))
      end, { desc = "run test file" })

      vim.keymap.set("n", "<leader>no", function()
        neotest.output.open()
      end, { desc = "open ouput" })

      vim.keymap.set("n", "<leader>ns", function()
        neotest.summary.toggle()
      end, { desc = "Open test summary" })

      require("neotest").setup({
        adapters = {
          require("neotest-java")({}),
        },
      })
    end,
  },
}
