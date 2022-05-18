local packer_status_ok, packer = pcall(require, "packer")
if packer_status_ok then
  local plugins = {
    -- Plugin manager
    {
      "wbthomason/packer.nvim",
    },
    -- gruvbox theme
    { "morhetz/gruvbox" },
    -- vimspector
    { "puremourning/vimspector" },

    -- Lua functions
    { "nvim-lua/plenary.nvim" },

    -- Popup API
    { "nvim-lua/popup.nvim" },

    --git copilot
    { "github/copilot.vim" },
    -- Git integration
    {
      "lewis6991/gitsigns.nvim",
      opt = true,
      setup = function()
        require("core.utils").defer_plugin "gitsigns.nvim"
      end,
      config = function()
        require("configs.gitsigns").config()
      end,
    },
    -- Notification Enhancer
    {
      "rcarriga/nvim-notify",
      config = function()
        require("configs.notify").config()
      end,
    },
    -- Parenthesis highlighting
    {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
    },
    -- -- Bufferline
    {
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config = function()
        require("configs.bufferline").config()
      end,
    },
    -- Parenthesis highlighting
    {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter",
    },

    -- Autoclose tags
    {
      "windwp/nvim-ts-autotag",
      after = "nvim-treesitter",
    },
    -- Better buffer closing
    {
      "moll/vim-bbye",
      cmd = { "Bdelete", "Bwipeout" },
    },

    -- Commenting
    {
      "numToStr/Comment.nvim",
      event = "InsertEnter",
      config = function()
        require("configs.Comment").config()
      end,
    },
    -- Context based commenting
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
    },
    -- Start screen
    {
      "glepnir/dashboard-nvim",
      config = function()
        require("configs.dashboard").config()
      end,
    },

    -- Syntax highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = { "BufRead", "BufNewFile" },
      cmd = {
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
        "TSDisableAll",
        "TSEnableAll",
      },
      config = function()
        require("configs.treesitter").config()
      end,
    },
    -- File explorer
    {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "Neotree",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("configs.neo-tree").config()
      end,
    },
    -- Fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      module = "telescope",
      config = function()
        require("configs.telescope").config()
      end,
    },
    -- Fuzzy finder syntax support
    {
      ("nvim-telescope/telescope-%s-native.nvim"):format(vim.fn.has "win32" == 1 and "fzy" or "fzf"),
      after = "telescope.nvim",
      run = "make",
      config = function()
        require("telescope").load_extension(vim.fn.has "win32" == 1 and "fzy_native" or "fzf")
      end,
    },
    -- Smooth scrolling
    {
      "karb94/neoscroll.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("configs.neoscroll").config()
      end,
    },
    -- Statusline
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("configs.lualine").config()
      end,
    },

    -- Built-in LSP
    {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      opt = true,
      setup = function()
        require("core.utils").defer_plugin "nvim-lspconfig"
      end,
    },

    -- LSP manager
    {
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
      config = function()
        require("configs.nvim-lsp-installer").config()
        require "configs.lsp"
      end,
    },

    -- LSP symbols
    {
      "stevearc/aerial.nvim",
      opt = true,
      setup = function()
        require("core.utils").defer_plugin "aerial.nvim"
      end,
      config = function()
        require("configs.aerial").config()
      end,
    },

    { "sar/cmp-lsp.nvim" },

    -- Snippet collection
    {
      "rafamadriz/friendly-snippets",
      after = "nvim-cmp",
    },

    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      after = "friendly-snippets",
      config = function()
        require("configs.luasnip").config()
      end,
    },


    {
      "hrsh7th/cmp-nvim-lsp",
      config = function()
        -- require("configs.cmp-lsp").config()
      end,
    },
    -- Snippet completion source
    {
      "saadparwaiz1/cmp_luasnip",
      after = "nvim-cmp",
      config = function()
        require("core.utils").add_user_cmp_source "luasnip"
      end,
    },
    -- Completion engine
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("configs.cmp").config()
      end,
    },


    -- Terminal
    {
      "akinsho/nvim-toggleterm.lua",
      cmd = "ToggleTerm",
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("configs.toggleterm").config()
      end,
    },

    -- Keymaps popup
    {
      "folke/which-key.nvim",
      config = function()
        require("configs.which-key").config()
      end,
    },
    -- Completion engine
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require("configs.cmp").config()
      end,
    },

    -- Buffer completion source
    {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
      config = function()
        require("core.utils").add_user_cmp_source "buffer"
      end,
    },

    -- Path completion source
    {
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
      config = function()
        require("core.utils").add_user_cmp_source "path"
      end,
    },
    -- Color highlighting
    {
      "norcalli/nvim-colorizer.lua",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("configs.colorizer").config()
      end,
    },
  }

  packer.startup {
    function(use)
      -- Load plugins!
      for _, plugin in pairs(
        require("core.utils").user_plugin_opts("plugins.init", require("core.utils").label_plugins(plugins))
      ) do
        use(plugin)
      end
    end,
    auto_clean = true,
    compile_on_sync = true,
  }
end
