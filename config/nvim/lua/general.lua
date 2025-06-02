vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("Gdbpath", function()
    local path = (vim.fn.expand("%:h") .. '/' .. vim.fn.expand("%:t") .. ':' .. vim.fn.line("."))
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

-- get git blame for a single line
function _G.git_commit_message()
    local file_path = vim.fn.expand("%:p")
    local line_number = vim.fn.line(".")

    local blame_cmd = "git blame -L " .. line_number .. "," .. line_number .. " -- '" .. file_path .. "' | awk '{print $1}' | head -1"
    local commit_hash = vim.fn.system(blame_cmd):gsub("\n", "")

    local show_cmd = "git show --format='%B' --no-patch " .. commit_hash
    local commit_message = vim.fn.system(show_cmd)

    -- Display the commit message in a floating popup or command line
    vim.api.nvim_echo({{commit_message, "Normal"}}, false, {})
end

-- Keybinding to run the function
vim.api.nvim_set_keymap('n', '<leader>gm', [[<Cmd>lua git_commit_message()<CR>]], { noremap = true, silent = true })

-- colorschemes
require("flow").setup({
      transparent = false,
      fluo_color = "pink",
      mode = "bright",
      aggressive_spell = true,
})

-- Delete lsp log
-- local lsp_log_file = vim.fn.expand("~/.cache/nvim/lsp.log")
local lsp_log_file = vim.fn.expand("~/.local/state/nvim/lsp.log")
if vim.fn.filereadable(lsp_log_file) == 1 then
  os.remove(lsp_log_file)
end

------------------------
-- For assembly files it's nice to have the first word have 4 character space between the next word
-- Utility for that -
-- Modified function that takes start/end lines as arguments
local function FormatFirstWordSpacing(start_line, end_line)
  for line_num = start_line, end_line do
    local line = vim.fn.getline(line_num)
    local first, second = line:match("^%s*(%S+)%s+(.*)")
    if first and second then
      local formatted = string.format("%-4s    %s", first, second)
      vim.fn.setline(line_num, formatted)
    end
  end
end

-- Command still exists if you want to call manually
vim.api.nvim_create_user_command("FormatFirstWord", function()
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]
  FormatFirstWordSpacing(start_line, end_line)
end, {})

-- Filetype-specific keymap for asm
vim.api.nvim_create_autocmd("FileType", {
  pattern = "asm",
  callback = function()
    vim.keymap.set('x', 'g=', function()
      -- Get range BEFORE visual mode exits
      local start_line = vim.fn.line("v")
      local end_line = vim.fn.line(".")
      if start_line > end_line then
        start_line, end_line = end_line, start_line
      end
      FormatFirstWordSpacing(start_line, end_line)
    end, { noremap = true, silent = true, buffer = true })
  end,
})
------------------------
