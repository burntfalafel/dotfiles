local cpp_compiler = "g++"
local c_compiler = "gcc"
local attempt = require('attempt')
attempt.setup{
  dir = '/home/easwad01/.local/share/nvim/' .. 'attempt.nvim',
  autosave = false,
  list_buffers = false,     -- This will make them show on other pickers (like :Telescope buffers)
  initial_content = {
    py = initial_content_fn, -- Either string or function that returns the initial content
    c = initial_content_fn,
    cpp = initial_content_fn,
    java = initial_content_fn,
    rs = initial_content_fn,
    go = initial_content_fn,
    sh = initial_content_fn
  },
  ext_options = { 'lua', 'js', 'py', 'cpp', 'c', '' },  -- Options to choose from
  format_opts = { [''] = '[None]' },                    -- How they'll look
  run = {
    py = { 'w !python' },      -- Either table of strings or lua functions
    js = { 'w !node' },
    ts = { 'w !deno run -' },
    lua = { 'w' , 'luafile %' },
    sh = { 'w !bash' },
    pl = { 'w !perl' },
    cpp = { 'w' , '!'.. cpp_compiler ..' %:p -o %:p:r.out && echo "" && %:p:r.out && rm %:p:r.out '},
    c = { 'w' , '!'.. c_compiler ..' %:p -o %:p:r.out && echo "" && %:p:r.out && rm %:p:r.out'},
  }
}
-- (You may omit the settings whose defaults you're ok with)
--

require('telescope').load_extension 'attempt'
local map = vim.keymap.set

map('n', '<leader>an', attempt.new_select)        -- new attempt, selecting extension
map('n', '<leader>ai', attempt.new_input_ext)     -- new attempt, inputing extension
map('n', '<leader>ar', attempt.run)               -- run attempt
map('n', '<leader>ad', attempt.delete_buf)        -- delete attempt from current buffer
map('n', '<leader>ac', attempt.rename_buf)        -- rename attempt from current buffer
map('n', '<leader>al', ':Telescope attempt<CR>')       -- search through attempts
