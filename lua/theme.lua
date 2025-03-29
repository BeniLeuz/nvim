-- nice colorscheme bozo
vim.cmd('colorscheme default')

-- Choose a high contrast color for types
local type_color = { fg = "#729FCF", bold = true }  -- Bold bright blue

-- Choose a color for variables (could be the same as types if you prefer)
local var_color = { fg = "#729FCF" }  -- Same color as types, but without bold

-- Link all type-related syntax groups to the same highlight
local type_groups = {
  "Type", "StorageClass", "Structure", "Typedef",
  "TSType", "TSTypeBuiltin", "TSTypeDefinition", 
  "TSTypeQualifier", "TSNamespace"
}

-- Variable-related groups
local var_groups = {
  "Identifier", "TSVariable", "TSVariableBuiltin", 
  "TSParameter", "TSProperty", "TSField"
}

-- Apply type color to all type groups
for _, group in ipairs(type_groups) do
  vim.api.nvim_set_hl(0, group, type_color)
end

-- Apply variable color to all variable groups
for _, group in ipairs(var_groups) do
  vim.api.nvim_set_hl(0, group, var_color)
end

-- You can still keep different colors for other syntax elements
vim.api.nvim_set_hl(0, "Function", { fg = "#A6E22E" })  -- Functions in green
vim.api.nvim_set_hl(0, "Keyword", { fg = "#F92672" })   -- Keywords in pink
vim.api.nvim_set_hl(0, "String", { fg = "#E6DB74" })    -- Strings in yellow

vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
