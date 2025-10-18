vim.g.vimtex_view_method = "sioyek"

vim.g.vimtex_compiler_latexmk = {
  build_dir = 'build',  -- folder for auxiliary files
  options = {
    '-pdf',          -- produce PDF
    '-interaction=nonstopmode', -- continue past errors
    '-synctex=1',    -- for forward/inverse search
    '-outdir=build', -- tell latexmk to write aux files here
  },
}
