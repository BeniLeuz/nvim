local type_color = { fg = "#ff9e64" }
local var_color = { fg = "#73daca" }

local type_groups = {
  "@type", "@type.builtin", "@type.definition",
  "@type.qualifier", "@namespace"
}

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

-- html tag
vim.api.nvim_set_hl(0, "@tag.html", { fg = "#729FCF" })

-- words like struct, class local function etc
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFCF70" })
vim.api.nvim_set_hl(0, "Function", { fg = "#729FCF" })
vim.api.nvim_set_hl(0, "String", { fg = "#B2DC7E" })

-- make it all black lmao
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000" })

-- scrollbar lol on completion
-- vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#000000" })
-- scrollbar is this lol
-- vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#000000" })
