local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fq', function()
  require('telescope').extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true
  })
end, { desc = "file browser" })

vim.keymap.set('n',  '<leader>ft', builtin.oldfiles, { desc = "Find recently opened files" })
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>,",  require('telescope').extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>fw", lga_shortcuts.grep_word_under_cursor, { desc = "Find current Word" })
vim.keymap.set("v", "<leader>,",  lga_shortcuts.grep_visual_selection, { desc = "Find by Grep (Visual)" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({ follow = true, no_ignore = true, hidden = true }) end)
vim.keymap.set("n", "<leader>fz", function() builtin.live_grep({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u', '--multiline', '--multiline-dotall' } }) end)
require('telescope').setup{
  defaults = {
        wrap_results = true,
        file_ignore_patterns = {".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
            "%.so", "%.o", "%.xml", "%.zip",
            "%.d", "^GUI/", "MaxCore/", "TestLibs/", "TestOutput/","ModelNetworking/", "LISATools/", "FeatureConfigs/" },
        history = {
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        },
        treesitter = true,
         mappings = {
              i = {
                -- Another example using Ctrl-j and Ctrl-k
                -- ["<C-j>"] = actions.cycle_history_prev,
                -- ["<C-k>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_next,
                ["<C-j>"] = actions.cycle_history_prev,
              },
        },
        -- sorting_strategy = "ascending",
        wrap_results = true,
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
    },
    pickers = {
				-- colorscheme = { enable_preview = true },
				find_files = {
					hidden = true,
					no_ignore = true,
				},
				live_grep = {
					additional_args = function(_)
						return { "--hidden", "--no-ignore" }
					end,
				},
				grep_string = {
					additional_args = function(_)
						return { "--hidden", "--no-ignore" }
					end,
				},
				current_buffer_fuzzy_find = {
					layout_strategy = "vertical",
					previewer = enable,
					layout_config = {
						vertical = {
							prompt_position = "top",
						},
					},
				},
                lsp_document_symbols = {
                    symbol_width = 100
                },
                lsp_workspace_symbols = {
                    fname_width = 120
                },
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
					hidden = { file_browser = true, folder_browser = true },
				},
			},
}
require('telescope').load_extension('smart_history')
