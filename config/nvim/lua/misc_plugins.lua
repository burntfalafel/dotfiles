vim.g.NERDSpaceDelims = 1
vim.g.NERDAltDelims_cpp = 1
vim.g.NERDAltDelims_c = 1
vim.g.NERDCustomDelimiters = {
  s = { left = "//", right = "" },
  S = { left = "//", right = "" },
  i = { left = "//", right = "" },
}

vim.g.DoxygenToolkit_authorName = "Eashan Wadhwa"
vim.g.DoxygenToolkit_commentType = "C"

-- Miscellaneous plugins
require("blame").setup()
require("notify").setup({
  background_color = "#282c34",
  timeout = 2000,
})

vim.keymap.set("n", "<leader>code", function()
  require("export-to-vscode").launch()
end, { silent = true })

vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-J>", [[copilot#Accept("\<CR>")]], {
  expr = true,
  replace_keycodes = false,
  silent = true,
})
