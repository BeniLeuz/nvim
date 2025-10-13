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
-- because java is sus
vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { fg = "#FFCF70" })

-- words like struct, class local function etc
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFCF70" })
vim.api.nvim_set_hl(0, "Function", { fg = "#729FCF" })
vim.api.nvim_set_hl(0, "String", { fg = "#B2DC7E" })

-- make it all black lmao
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000" })

-- make dirs the same color as debian dirs
-- printf "\033]4;12;?\033\\"
vim.api.nvim_set_hl(0, "Directory", { fg = "#6871ff" })

-- tabline
-- vim.api.nvim_set_hl(0, "TabLine", { bg = "#1a1a1a", fg = "#666666" })      -- inactive: dark gray
-- vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#ffffff", fg = "#000000", bold = true })  -- active: white bg, black text
-- vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#000000" })

vim.api.nvim_set_hl(0, "TabLine", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#ffffff", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#000000" })


-- statusline (works because i set highlight groups in vimopts)
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#000000" })       -- white text on black
vim.api.nvim_set_hl(0, "StatusModified", { fg = "#ffffff", bg = "#000000" })   -- orange on black
vim.api.nvim_set_hl(0, "StatusRO", { fg = "#ffffff", bg = "#000000" })   -- orange on black

function _G.custom_tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    local cwd = vim.fn.getcwd(-1, i)
    cwd = vim.fn.fnamemodify(cwd, ":t")
    s = s .. " " .. cwd .. " "
  end

  -- Fill empty space and reset tab target
  s = s .. "%#TabLineFill#"
  return s
end

-- some fugitive styling
vim.api.nvim_set_hl(0, "DiffDelete", {
  bg = "#330000",
})

vim.api.nvim_set_hl(0, "diffRemoved", { link = "DiffDelete" })
vim.o.tabline = "%!v:lua.custom_tabline()"
vim.api.nvim_set_hl(0, "diffAdded", { link = "DiffAdd"})

