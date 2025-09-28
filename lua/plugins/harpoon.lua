return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        select_with_nil = true
      },
    })

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set({ "n", "t" }, "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set({ "n" }, "<C-c>", function() harpoon.ui:close_menu() end)
    vim.keymap.set({ "n", "t" }, "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set({ "n", "t" }, "<C-j>", function() harpoon:list():select(2) end)
    vim.keymap.set({ "n", "t" }, "<C-k>", function() harpoon:list():select(3) end)
    vim.keymap.set({ "n", "t" }, "<C-l>", function() harpoon:list():select(4) end)


    -- make seperate lists depending on current tab directory
    local function terminals()
      return harpoon:list("terms::" .. vim.api.nvim_get_current_tabpage())
    end

    local function create_terminal()
      vim.cmd("terminal")
      local buf_id = vim.api.nvim_get_current_buf()
      return vim.api.nvim_buf_get_name(buf_id)
    end

    ---@param index number: The index of the terminal to select.
    local function select_term(index)
      local term_list = terminals()
      if index > term_list:length() then
        create_terminal()
        term_list:add()
      else
        term_list:select(index)
      end
    end

    local function remove_closed_terms()
      local term_list = terminals()

      for _, term in ipairs(term_list.items) do
        local bufnr = vim.fn.bufnr(term.value)
        if bufnr == -1 then
          term_list:remove(term)
        end
        -- can get id here with nvim_buf_get_name because buffer is already deleted
        --term_list:remove(term_name)
        --
      end
    end

    -- Autocommand to remove closed terminal from the list
    -- "VimEnter" cleans terminals that were saved when you closed vim for the last time but were not removed
    vim.api.nvim_create_autocmd({ "TermClose", "VimEnter" }, {
      pattern = "*",
      callback = remove_closed_terms,
    })

    -- This is needed because closing term with bd! won't trigger "TermClose"
    vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, {
      pattern = "term://*",
      callback = remove_closed_terms,
    })

    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      pattern = "term://*",
      callback = function()
        -- vim.cmd(':startinsert')
        vim.o.number = true
        vim.o.relativenumber = true
        vim.wo.wrap = false
      end,
    })

    vim.keymap.set({ "n" }, "<leader>h", function() select_term(1) end)
    vim.keymap.set({ "n" }, "<leader>j", function() select_term(2) end)
    vim.keymap.set({ "n" }, "<leader>k", function() select_term(3) end)
    vim.keymap.set({ "n" }, "<leader>l", function() select_term(4) end)

    -- probably not the right keybind for this, since control -n goes back to next in terminal mode.. might be use ful
    -- to never need arrow functions tbh

    vim.keymap.set({ "n", "t" }, "<C-g>", function() harpoon.ui:toggle_quick_menu(terminals()) end)
  end
}
