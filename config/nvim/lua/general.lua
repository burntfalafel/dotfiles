vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

local builtin = require('telescope.builtin')
vim.api.nvim_create_user_command("TelescopeCppPathFiles", function()
    local current_file_path = vim.fn.expand('%:p')
    local directory_path = current_file_path:match('(.*' .. vim.fn.escape(vim.fn.expand('%:t'), '.') .. ')$')
    builtin.find_files({search_dir=directory_path})
end, {})

vim.api.nvim_create_user_command("TelescopeCppPathGrep", function()
    local current_file_path = vim.fn.expand('%:p')
    local directory_path = current_file_path:match('(.*' .. vim.fn.escape(vim.fn.expand('%:t'), '.') .. ')$')
    builtin.live_grep({search_dir=directory_path})
end, {})


-- When you press the carriage return key (cr) in normal mode, this key mapping will execute the ciw command. The ciw command changes the inner word, which means it selects the word under the cursor and enters insert mode, allowing you to modify the word.
-- vim.keymap.set(“n”, “<cr>”, “ciw”)
--

-- https://superuser.com/questions/321547/how-do-i-replace-paste-yanked-text-in-vim-without-yanking-the-deleted-lines
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- https://github.com/Eandrju/cellular-automaton.nvim
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
