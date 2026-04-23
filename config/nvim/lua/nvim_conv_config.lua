-- HEX
vim.keymap.set("v", "<leader>ch", function()
  vim.cmd('normal! "vy')
  vim.cmd("ConvHex " .. vim.fn.getreg("v"))
end)

-- DEC
vim.keymap.set("v", "<leader>cd", function()
  vim.cmd('normal! "vy')
  vim.cmd("ConvDec " .. vim.fn.getreg("v"))
end)
