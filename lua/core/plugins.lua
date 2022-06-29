local packer_status_ok, packer = pcall(require, "packer")

if packer_status_ok then
    local plugins = {
        -- Plugin manager
        {
            "wbthomason/packer.nvim", },
        {
            "lewis6991/impatient.nvim",
            config = function()
                require('impatient')
                vim.g.impatient_show_count = 1
                vim.g.impatient_show_count_format = " %d "

            end,
        },
        { "dstein64/vim-startuptime" },
        -- Cursorhold fix
        {
            "antoinemadec/FixCursorHold.nvim",
            event = "BufRead",
            config = function()
                vim.g.cursorhold_updatetime = 100
            end,
        },
        { "Djancyp/lsp-range-format",
        },
        { "catppuccin/nvim",
            as = "catppuccin" },
        -- Custom Plugin dev
        {
            "Djancyp/symbol-winbar",
            config = function()
                require('symbols-winbar').setup({
                    lsp = false,
                    gps = false,
                })
            end,
        },
        { "Djancyp/cheat-sheet" },
        {
            "Djancyp/outline",
            config = function()
                require('outline').setup()
            end,
        },
        { "vimwiki/vimwiki" },
        { "mattn/emmet-vim" },
        { "tpope/vim-surround" },
        { "jose-elias-alvarez/nvim-lsp-ts-utils" },
        -- { "olimorris/onedarkpro.nvim" },
        -- gruvbox theme
        { "sainnhe/gruvbox-material" },
        -- theme
        { "EdenEast/nightfox.nvim" },
        -- Lua functions
        { "nvim-lua/plenary.nvim" },

        -- Popup API
        { "nvim-lua/popup.nvim" },

        { "NTBBloodbath/rest.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require('configs.rest').setup()
            end,
        },
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
        {
            "windwp/nvim-ts-autotag",
            config = function()
            end,
        },
        -- autopairs
        {
            "windwp/nvim-autopairs",
            config = function()
                require('nvim-autopairs').setup({
                    fast_wrap = {
                        map = '<M-e>',
                        chars = { '{', '[', '(', '"', "'" },
                        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
                        end_key = '$',
                        keys = 'qwertyuiopzxcvbnmasdfghjkl',
                        check_comma = true,
                        highlight = 'Search',
                        highlight_grey = 'Comment'
                    },
                    disable_filetype = { "TelescopePrompt", "vim" },
                })
            end
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            config = function()

                vim.opt.termguicolors = true
                vim.opt.list = true

                require("indent_blankline").setup {
                    buftype_exclude = {
                        "nofile",
                        "terminal",
                        "lsp-installer",
                        "lspinfo",
                    },
                    filetype_exclude = {
                        "help",
                        "startify",
                        "aerial",
                        "alpha",
                        "dashboard",
                        "packer",
                        "neogitstatus",
                        "NvimTree",
                        "neo-tree",
                        "Trouble",
                    },
                    context_patterns = {
                        "class",
                        "return",
                        "function",
                        "method",
                        "^if",
                        "^while",
                        "jsx_element",
                        "^for",
                        "^object",
                        "^table",
                        "block",
                        "arguments",
                        "if_statement",
                        "else_clause",
                        "jsx_element",
                        "jsx_self_closing_element",
                        "try_statement",
                        "catch_clause",
                        "import_statement",
                        "operation_type",
                    },
                    show_trailing_blankline_indent = false,
                    use_treesitter = true,
                    char = "▏",
                    context_char = "▏",
                    show_current_context = true, }
            end,
        },
        -- Better buffer closing
        {
            "moll/vim-bbye",
            cmd = { "Bdelete", "Bwipeout" },
        },

        -- Commenting
        {
            "numToStr/Comment.nvim",
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
            "goolord/alpha-nvim",
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
            "declancm/cinnamon.nvim",
            event = { "BufRead", "BufNewFile" },
            config = function()
                require("configs.neoscroll").config()
            end,
        },
        -- Statusline
        { "feline-nvim/feline.nvim",
            after = "nvim-web-devicons",
            config = function()
                require "configs.feline"
            end,
        },

        -- Built-in LSP
        {
            "neovim/nvim-lspconfig",
            module = "lspconfig",
            opt = true,
            setup = function()

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
        {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require("configs.lsp.null-ls").setup()
            end,
        },
        -- Neovim UI Enhancer
        {
            "stevearc/dressing.nvim",
            event = "BufWinEnter",
            config = function()
                require("configs.dressing").config()
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
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
            end,
        },
        { "~/Documents/nvim/lsp-ts",
            after = "LuaSnip",
            config = function()
                require('lsp-ts').setup()
            end
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
        -- Smarter Splits
        {
            "mrjones2014/smart-splits.nvim",
            module = "smart-splits",
            config = function()
                require("configs.smart-splits").config()
            end,
        },
        { "mfussenegger/nvim-dap",
            config = function()
                require("configs.dap").config()
            end,
        },
        -- {
        --   "rcarriga/nvim-dap-ui",
        --   requires = { "nvim-dap" },
        --   config = function()
        --     require("configs.dap").ui_config()
        --   end,
        -- },
        {
            "uelei/DAPInstall.nvim",
            config = function()
                -- require("configs.dap").install_config()
            end,
        },
        { "nvim-telescope/telescope-dap.nvim",
            config = function()
                require('telescope').load_extension('dap')
            end,
        },
        { "theHamsta/nvim-dap-virtual-text",
            config = function()
                require('nvim-dap-virtual-text').setup()
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
