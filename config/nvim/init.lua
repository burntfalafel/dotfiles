vim.g.python_host_prog = "/usr/bin/python"
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.mapleader = ","

vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("on")

vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "120"
vim.opt.wrap = true
vim.opt.wildmenu = true
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.fn.matchadd("Error", [[{{{\|}}}]])

vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true

pcall(function()
  vim.opt.ttyfast = true
end)
vim.opt.errorbells = false
vim.opt.visualbell = false
pcall(function()
  vim.opt.t_vb = ""
end)
vim.opt.lazyredraw = true
vim.opt.hidden = true

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.foldmethod = "marker"
vim.opt.cinoptions = "N-s"

vim.opt.exrc = true
vim.opt.wildignore = { "*.so", "*.sw", "*.pyc" }
vim.opt.mouse = "a"
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.matchpairs:append("<:>")
vim.opt.fileformats = { "unix" }
vim.opt.spelllang = "en_gb"
vim.opt.spell = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("ExpandtabFTW"),
  pattern = "*",
  callback = function()
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("TrimTrailingWhitespace"),
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

local map = vim.keymap.set
local silent = { silent = true }

map("n", "Q", "<Nop>")
map("n", "/", "/\\v")
map("x", "/", "/\\v")
map("x", ".", ":normal .<CR>")

map("n", "<leader>pv", "<cmd>Explore<CR>", silent)
map("n", "<F2>", "<cmd>tabprevious<CR>", silent)
map("n", "<F4>", "<cmd>tabnew<CR>", silent)
map("n", "<F3>", "<cmd>e ~/.local/fm_scripts/run_test.sh<CR>", silent)
map("n", "<F15>", "<cmd>e /home/easwad01/.config/nvim/init.lua<CR>", silent)

map("n", "<leader>k", "<cmd>next<CR>", silent)
map("n", "<leader>j", "<cmd>previous<CR>", silent)
map("n", "<leader>q", "<cmd>q<CR>", silent)
map("n", "<leader>w", "<cmd>w!<CR>", silent)
map("n", "<leader>gs", "<cmd>Git<CR>", silent)
map("n", "<leader>s", "<cmd>!tmux new-window -n \"runner-vim\" -d 'ninja -C ../build/gcc-10.3.0/dbg VAL_VAL_AEMvA'<CR>", silent)
map("n", "<leader>d", "<cmd>Gdiff<CR>", silent)
map("n", "<leader>/", "<cmd>nohlsearch<CR>", silent)
map("n", "<leader><space>", "<cmd>noh<CR>")
map("n", "<leader>r", [[:,$s/\<<C-r><C-w>\>//gc\|1,''-&&<left><left><left><left><left><left><left><left><left><left><left>]])

map({ "n", "x", "o" }, "<C-J>", "<C-W><C-J>")
map({ "n", "x", "o" }, "<C-H>", "<C-W><C-H>")
map({ "n", "x", "o" }, "<C-K>", "<C-W><C-K>")
map({ "n", "x", "o" }, "<C-L>", "<C-W><C-L>")
map({ "n", "x", "o" }, "<C-]>", "<C-W><C-S>")
map({ "n", "x", "o" }, "<C-\\>", "<C-W><C-V>")
map({ "n", "x", "o" }, "<C-Q>", "<C-W><C-Q>")
map("n", "<C-Z>", "<C-R>")

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("SpellingMappings"),
  pattern = { "markdown", "vimwiki" },
  callback = function(event)
    map("i", "<C-L>", "<C-G>u<Esc>[s1z=`]a<C-G>u", { buffer = event.buf })
    map({ "n", "x", "o" }, "<C-J>", "<Esc>b[sviw<C-G>", { buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("MakefileTabs"),
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CodeFormatters"),
  pattern = { "cpp", "c" },
  callback = function(event)
    map("n", "<leader>o", "<cmd>!clang-format --style=file -i %:p<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("PythonFormatter"),
  pattern = "python",
  callback = function(event)
    map("n", "<leader>o", "<cmd>!autopep8 -i -a --ignore=E128 --max-line-length=120 %:p<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("RestoreCursorPosition"),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  group = augroup("AssemblyFiletypes"),
  pattern = { "*.i", "*.S" },
  callback = function()
    vim.bo.filetype = "asm"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufReadPost" }, {
  group = augroup("TarmacFiletype"),
  pattern = "*.tarmac",
  callback = function()
    vim.bo.filetype = "tarmac"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("TarmacFiles"),
  pattern = "tarmac",
  callback = function()
    vim.api.nvim_set_hl(0, "@mmu_events.tarmac", { default = true, link = "Special" })
    vim.api.nvim_set_hl(0, "@testcase.tarmac", { default = true, link = "Title" })
    require("tarmac_folds").setup()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("TarmacStripAnsi"),
  pattern = "*.tarmac",
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local changed = false
    for idx, line in ipairs(lines) do
      local cleaned = line:gsub("\27%[[0-9;]*[mK]", "")
      if cleaned ~= line then
        lines[idx] = cleaned
        changed = true
      end
    end
    if changed then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("AsmIndent"),
  pattern = "asm",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

map("c", "w!!", "w !sudo tee >/dev/null %", { noremap = true })

for lhs, rhs in pairs({
  W = "w",
  Wq = "wq",
  wQ = "wq",
  WQ = "wq",
  Q = "q",
  WQA = "wqa",
  Wqa = "wqa",
}) do
  vim.cmd.cnoreabbrev(lhs .. " " .. rhs)
end

map("n", "<C-Down>", ":split")
map("n", "<C-Right>", "<cmd>bnext<CR>")
map("n", "<C-Left>", "<cmd>bprev<CR>")
map("n", "<C-Up>", "<cmd>BufferClose<CR>")
map("n", "<C-e>", "<cmd>E<CR>")
map("n", "<S-Up>", "<C-w>5-")
map("n", "<S-Down>", "<C-w>5+")
map("n", "<S-Left>", "<C-w>10<")
map("n", "<S-Right>", "<C-w>10>")
map("t", "<Esc>", "<C-\\><C-n>")

map("n", "<leader>;", "<C-w>p", silent)
map("n", "<leader>wp", "<C-w>p", silent)
map("n", "<leader>wr", "<cmd>copen<CR>", silent)
map("n", "<leader>wq", "<cmd>cclose<CR>", silent)
map("n", "<C-q>", "<cmd>cclose<CR>", silent)
map("n", "<leader>wn", "<cmd>cprev<CR>zz")
map("n", "<leader>wp", "<cmd>cnext<CR>zz")
map("n", "<leader>wm", "<cmd>MarksQFListAll<CR>")

require("setup_lazy")
require("general")
require("misc_plugins")
require("nvim_treesitter_config")
require("telescope_config")
require("nvim_cmp_config")

map("n", "<leader>v", "<cmd>Outline<CR>", silent)
require("symbolsoutline_config")
require("dap_rr_config")
require("barbar_config")

local colorschemes = { "carbonfox" }
pcall(vim.cmd.colorscheme, colorschemes[math.random(#colorschemes)])
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, fg = "#a0805d", sp = "#a0805d" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2c2c2c" })
vim.api.nvim_set_hl(0, "Normal", { bg = "#0b0b0b" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0b0b0b" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#0b0b0b" })

map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", silent)
require("harpoon_config")
require("refactor_config")
require("session_config")
require("attempt_config")
require("nvim_conv_config")
