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
    -- { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate"},
    { "burntfalafel/tree-sitter-tarmac", lazy = false},
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
    { "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
    { "MunifTanjim/nui.nvim", event = "VeryLazy" },
    { "VonHeikemen/fine-cmdline.nvim", event = "VeryLazy", cmd = "FineCmdLine" },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    { "rcarriga/nvim-notify", event = "VeryLazy"},

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
    { "github/copilot.vim" },
    {
      {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
          { "github/copilot.vim" },
          { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
          debug = true, -- Enable debugging
          -- See Configuration section for rest
        },
        lazy = false,
        -- See Commands section for default commands if you want to lazy load on them
      },
    },

    -- Telescope
    { "nvim-telescope/telescope.nvim", tag = "v0.2.2", cmd = "Telescope" },
    { "nvim-telescope/telescope-live-grep-args.nvim", cmd = "Telescope" },
    { "nvim-telescope/telescope-file-browser.nvim", cmd = "Telescope" },
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope-smart-history.nvim", cmd = "Telescope" },

    -- DAP
    {"williamboman/mason.nvim"},
    {"mfussenegger/nvim-dap"},
    {"jay-babu/mason-nvim-dap.nvim"},
    { "theHamsta/nvim-dap-virtual-text", dependencies = "nvim-dap" },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    { "mason-org/mason.nvim", opts = { ui = { icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            } } }
    },
    { "burntfalafel/nvim-dap-rr", dependencies = {"nvim-dap", "telescope.nvim"}},

    -- Convert numbers
    { "simonefranza/nvim-conv"},

    -- Refactoring
    { "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "lewis6991/async.nvim",
      },
      lazy = false,
    },

    -- ARM syntax
    -- { "ARM9/arm-syntax-vim", ft = { "arm", "s" } },

    -- Auto-session
    { "rmagatti/auto-session", lazy = false },

    -- FZF
    -- { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end, cmd = "FZF" },
    { "junegunn/fzf" },

    -- Your custom plugin
    { "burntfalafel/signaltmux.nvim", event = "VeryLazy" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true,
              notify = false },
})
