local M = {}

--- Set up the termbuf autocmds to hook into opened terminal buffers
---@param config TermBufConfig
---@return nil
local function setup_auto_cmds(config)
  local augr_term = vim.api.nvim_create_augroup("termbuf", { clear = true })

  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "term://",
    group = augr_term,
    callback = function(args)
      M.buffers[args.buf] = {
        keybinds = M.default_keybinds
      }

      -- setup specific keybinds like dd etc
      vim.api.nvim_create_augroup("local-termbuf", { clear = true })



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
  M.buffers = {};
  M.prompts = config.prompts or {}
  M.default_keybinds = (config or {}).default_keybinds or {
    clear_current_line = '<C-e><C-u>',
    forward_char = '<C-f>',
    goto_line_start = '<C-a>',
  }

  setup_auto_cmds(config)
end

return M
