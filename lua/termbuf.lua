local M = {}



local function setup_keybinds()
  -- vim.keymap.set('n', 'A', function()
  -- end, { pattern = M.buf_pattern })
  --
  -- vim.keymap.set('n', 'I', function()
  -- end, { pattern = M.buf_pattern})
  --
  -- vim.keymap.set('n', 'i', function()
  -- end, { pattern = M.buf_pattern})
  --
  -- vim.keymap.set('n', 'a', function()
  -- end,{ pattern = M.buf_pattern})
  --
  -- vim.keymap.set('n', 'dd', function()
  -- end, { pattern = M.buf_pattern })
end

local function setup_cmds()
  local group = vim.api.nvim_create_augroup("termbuf-edit", {});

  -- magic begins
  -- when term leave we update our line for prompt
  -- when term enter we clear the line neovim would do and add ours we have ready from termleave or textchanged not sure

  vim.api.nvim_create_autocmd("TermEnter", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]

      if (buf.prompt_cursor.row == nil or buf.prompt_cursor.col == nil) then
        return
      end

      print(buf.prompt_cursor)
    end
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      local cur = vim.api.nvim_win_get_cursor(0)
      vim.bo.modifiable = buf.prompt_cursor.row == cur[1] and buf.prompt_cursor.col <= cur[2]
    end
  })

  vim.api.nvim_create_autocmd("TermLeave", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line = vim.api.nvim_get_current_line()

      for prompt, _ in pairs(M.prompts) do
        s, e = line:find(prompt)
        if (s ~= nil) then
          buf.prompt_cursor = {
            row = cursor[1],
            col = e
          }
        end
      end
    end
  })
end

--- Set up the plugin internally on termopen
---@return nil
local function setup()
  local augr_term = vim.api.nvim_create_augroup("termbuf", { clear = true })

  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = M.buf_pattern,
    group = augr_term,
    callback = function(args)
      -- setup default values 
      M.buffers[args.buf] = {
        keybinds = M.default_keybinds,
        prompt_cursor = {
          row = nil,
          col = nil
        }
      }



      setup_keybinds()
      setup_cmds()
    end
  })
end

---@class Keybinds
---@field clear_current_line string Key to clear the current line in editable regions
---@field forward_char string Key to move forward one character
---@field goto_line_start string Key to move to the start of the line

---@class PromptOptions
---@field keybinds? Keybinds Custom keybindings for this specific prompt pattern

---@class TermBufConfig
---@field prompts? {[string]: PromptOptions} Table of prompt patterns mapping to their options. Keys are Lua pattern strings that match terminal prompts (e.g., '.*[$#%%][ ]?')
---@field default_keybinds? Keybinds Default keybindings for your terminal

--- Set up the termbuf plugin with the configuration
---@param config TermBufConfig Configuration table for editable-term
---@return nil
M.setup = function(config)
  -- this might not make sense since modifiable ruined on different command term outputs
  M.buf_pattern = "term://*"
  M.buffers = {};
  M.prompts = config.prompts or {
    ['.*[$#%%][ ]?'] = {}

    -- todo
    -- not yet supported!
    -- if you want to add different keybinds for the a prompt
    -- ['# '] = {
    --   keybinds = {
    --     clear_current_line = '<C-e><C-u>',
    --     forward_char = '<C-f>',
    --     goto_line_start = '<C-a>',
    --   }
    -- }
  }

  M.default_keybinds = {
    clear_current_line = '<C-e><C-u>',
    forward_char = '<C-f>',
    goto_line_start = '<C-a>',
  }
  setup()
end

return M
