local M = {}

local function clear_line(buf)
  return vim.api.nvim_chan_send(vim.bo.channel,
    vim.api.nvim_replace_termcodes(buf.keybinds.clear_line, true, false, true))
end

local function insert_line(buf)
  return vim.api.nvim_chan_send(vim.bo.channel, buf.prompt.line)
end

-- todo: can we do this without flickering? at all?
-- like maybe in one function call will be faster and better? but i dont think that matters at all but atleast try it out man
local function update_line(buf)
  local err_clear = clear_line(buf)
  local err_insert = insert_line(buf)

  if (err_clear or err_insert) then
    return error("Wasn't able to update line in terminal")
  end
end

local function setup_keybinds()
  -- vim.keymap.set('n', 'I', function()
  -- end, { pattern = M.buf_pattern})
  --
  -- vim.keymap.set('n', 'i', function()
  -- end, { pattern = M.buf_pattern})
  --
  -- todo: will need to be able to also shift+v+d without actually deleting the front line.
  -- needs to be only line check and afterwards calculate.
  -- text yank post will not be good enough tbh but maybe there just is not another way..
  -- unless i actually remap a lot more than i thought necessary, i might just do.
  --
  -- vim.keymap.set('n', 'A', function()
  -- end, { pattern = M.buf_pattern })
  --
  --
  -- vim.keymap.set('n', 'a', function()
  -- end,{ pattern = M.buf_pattern})
  --
  -- vim.keymap.set('n', 'dd', function()
  -- end, { pattern = M.buf_pattern })
end

local function setup_cmds()
  local group = vim.api.nvim_create_augroup("termbuf-edit", {});

  vim.api.nvim_create_autocmd("TextChanged", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      -- this callback also will be called if you change inside terminal mode
      -- and then go back out then the line will also be updated.
      local buf = M.buffers[args.buf]

      if (buf.prompt.col == nil) then
        return
      end

      local line = vim.api.nvim_get_current_line()
      buf.prompt.line = line:sub(buf.prompt.col + 1)
    end
  })

  vim.api.nvim_create_autocmd("TextChangedT", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      if (buf.textyankpost) then
        local line = vim.api.nvim_get_current_line()
        buf.prompt.line = line:sub(buf.prompt.col + 1)
        update_line(buf)
      end
    end
  })

  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      buf.textyankpost = true
    end
  })

  vim.api.nvim_create_autocmd("TermResponse", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local cursor = vim.api.nvim_win_get_cursor(0)
      print("termresponse lol")
      print("cursor: " .. tostring(cursor[1]))
      print("cursor: " .. tostring(cursor[2]))
    end
  })

  -- todo:
  -- might be the reason iterm2 prompts get marked wronly
  -- Shells can emit semantic escape sequences (OSC 133) to mark where each prompt
  -- from terminal.txt
  -- starts and ends. The start of a prompt is marked by sequence `OSC 133 ; A ST`,
  -- and the end by `OSC 133 ; B ST`.
  --
  -- You can configure your shell "rc" (e.g. ~/.bashrc) to emit OSC 133 sequences,
  -- or your terminal may attempt to do it for you (assuming your shell config
  -- doesn't interfere).

  vim.api.nvim_create_autocmd("TermRequest", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local cursor = vim.api.nvim_win_get_cursor(0)
      print("termrequest lol")
      print("cursor: " .. tostring(cursor[1]))
      print("cursor: " .. tostring(cursor[2]))
    end
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      if (buf.prompt.row == nil or buf.prompt.col == nil) then
        return
      end
      update_line(buf)
    end
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      local cur = vim.api.nvim_win_get_cursor(0)
      vim.bo.modifiable = buf.prompt.row == cur[1] and buf.prompt.col <= cur[2]
    end
  })

  vim.api.nvim_create_autocmd("TermLeave", {
    pattern = M.buf_pattern,
    group = group,
    callback = function(args)
      local buf = M.buffers[args.buf]
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line = vim.api.nvim_get_current_line()

      -- generally textchanged is always triggered when there is something on the line already
      -- sadly you cant be sure that this is the case always when the line is actually empty
      -- therefore we need to set the line on termleave as well to be safe!
      for prompt, _ in pairs(M.prompts) do
        local s, e = line:find(prompt)
        if (s ~= nil) then
          buf.prompt = {
            line = line:sub(e + 1),
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
  setup_keybinds()
  setup_cmds()

  local augr_term = vim.api.nvim_create_augroup("termbuf", {})
  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = M.buf_pattern,
    group = augr_term,
    callback = function(args)
      -- setup default values
      M.buffers[args.buf] = {
        keybinds = M.default_keybinds,
        prompt = {
          line = nil,
          row = nil,
          col = nil
        },
        textyankpost = false
      }
    end
  })
end

---@class Keybinds
---@field clear_line string Key to clear the current line in editable regions
---@field move_char_forward string Key to move forward one character
---@field goto_startof_line string Key to move to the start of the line

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
    -- space needs to be included!!!
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
    clear_line = '<C-e><C-u>',
    move_char_forward = '<C-f>',
    goto_startof_line = '<C-a>',
  }
  setup()
end

return M
