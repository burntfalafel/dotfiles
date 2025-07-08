-- ~/.config/nvim/lua/lazy.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- Core functionality
    { "nvim-lua/plenary.nvim", lazy = false },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    { "nvim-treesitter/nvim-treesitter-context"},

    -- UI/UX
    { "mvllow/modes.nvim", event = "VeryLazy" },
    { "0xstepit/flow.nvim", event = "VeryLazy" },
    { "hedyhli/outline.nvim", cmd = "Outline" },
    { "preservim/nerdcommenter", event = "VeryLazy" },
    { "vim-scripts/DoxygenToolkit.vim", ft = { "c", "cpp", "h" } },
    { "drmikehenry/vim-headerguard", ft = { "c", "cpp", "h" } },
    { "kyazdani42/nvim-web-devicons", lazy = true },
    { "romgrk/barbar.nvim", event = "BufReadPost" },
    { "mbbill/undotree", cmd = "UndotreeToggle" },
    { "ThePrimeagen/harpoon", event = "VeryLazy" },
    { "m-demare/attempt.nvim", cmd = "Attempt" },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    { "elijahmanor/export-to-vscode.nvim", cmd = "ExportToVSCode" },
    { "FabijanZulj/blame.nvim", cmd = "BlameToggle" },
    { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },

    -- Git
    { "tpope/vim-fugitive", lazy = false },

    -- Completion
    { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp"},
    { "hrsh7th/cmp-buffer"},
    { "hrsh7th/cmp-path"},
    { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
    { "hrsh7th/vim-vsnip", event = "InsertEnter" },
    { "hrsh7th/cmp-vsnip", event = "InsertEnter" },
    -- UltiSnips support (disabled in your list but adding if needed)
    -- { "SirVer/ultisnips", ft = "snippets" },
    -- { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true },

    -- LSP
    { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
    { "williamboman/mason.nvim", build = ":MasonUpdate", cmd = "Mason" },
    { "williamboman/mason-lspconfig.nvim", lazy = true },

    -- Telescope
    { "nvim-telescope/telescope.nvim", tag = "0.1.8", cmd = "Telescope" },
    { "nvim-telescope/telescope-live-grep-args.nvim", cmd = "Telescope" },
    { "nvim-telescope/telescope-smart-history.nvim", cmd = "Telescope" },

    -- DAP
    { "mfussenegger/nvim-dap", lazy = true },
    { "nvim-neotest/nvim-nio", lazy = true },
    { "rcarriga/nvim-dap-ui", lazy = true },

    -- Refactoring
    { "ThePrimeagen/refactoring.nvim", event = "VeryLazy" },

    -- ARM syntax
    -- { "ARM9/arm-syntax-vim", ft = { "arm", "s" } },

    -- Auto-session
    { "rmagatti/auto-session", lazy = false },

    -- FZF
    { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end, cmd = "FZF" },

    -- Your custom plugin
    { "burntfalafel/signaltmux.nvim", event = "VeryLazy" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
