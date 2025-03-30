-- nice colorscheme legit best one honestly with adjustments
vim.cmd('colorscheme default')

-- goat
local type_color = { fg = "#ff9e64" }
local var_color = { fg = "#73daca" }
-- local type_color = { fg = "#D35400" }  -- Pumpkinw

-- Link all type-related syntax groups to the same highlight
local type_groups = {
  "@type", "@type.builtin", "@type.definition",
  "@type.qualifier", "@namespace"
}
-- Variable-related groups
local var_groups = {
  "@variable", "@variable.builtin", "@variable.local",
  "@parameter", "@property", "@field", "@identifier"
}

for _, group in ipairs(type_groups) do
  vim.api.nvim_set_hl(0, group, type_color)
end

for _, group in ipairs(var_groups) do
  vim.api.nvim_set_hl(0, group, var_color)
end

-- words like struct, class local function etc
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFCF70" })
vim.api.nvim_set_hl(0, "Function", { fg = "#729FCF" })
vim.api.nvim_set_hl(0, "String", { fg = "#B2DC7E" })

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
