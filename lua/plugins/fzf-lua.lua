return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "junegunn/fzf",
    config = function()
      -- Add fzf bin dir to PATH that we know its here or not
      local fzf_bin_path = vim.fn.stdpath("data") .. "/lazy/fzf/bin"
      vim.env.PATH = vim.env.PATH .. ":" .. fzf_bin_path


      if vim.fn.executable("fzf") == 0 then
        vim.cmd("call fzf#install()")
      end
    end,
  }
}
