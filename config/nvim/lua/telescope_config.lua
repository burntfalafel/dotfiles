local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({ follow = true, no_ignore = true, hidden = true }) end)
vim.keymap.set("n", "<leader>fz", function() builtin.live_grep({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }) end)
require('telescope').setup{
  defaults = {
    wrap_results = true,
    file_ignore_patterns = {".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
		"%.so", "%.o", "%.xml", "%.zip"}
  }
}
