local builtin_mark = require("harpoon.mark")
local builtin_ui = require("harpoon.ui")
vim.keymap.set('n', '<leader>ht', builtin_mark.add_file, {})
vim.keymap.set('n', '<leader>hr', builtin_mark.rm_file, {})
vim.keymap.set('n', '<leader>hg', builtin_ui.toggle_quick_menu, {})

