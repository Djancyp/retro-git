local M = {}

function M.config()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if status_ok then
        -- if #vim.api.nvim_list_uis() == 0 then
        --     return
        -- end
        treesitter.setup({
            on_config_done = nil,
            ensure_installed = { "http", "json", "rust", "javascript", "typescript", "html", "css", "scss" },
            ignore_install = {},
            auto_install = true,
            matchup = {
                enable = false, -- mandatory, false will disable the whole extension
                -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
            },
            highlight = {
                enable = true, -- false will disable the whole extension
                additional_vim_regex_highlighting = false,
                disable = { "latex" },
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
                config = {
                    -- Languages that have a single comment style
                    typescript = "// %s",
                    css = "/* %s */",
                    scss = "/* %s */",
                    html = "<!-- %s -->",
                    svelte = "<!-- %s -->",
                    vue = "<!-- %s -->",
                    json = "",
                },
            },
            indent = { enable = true, disable = { "yaml", "python" } },
            autotag = { enable = true },
            textobjects = {
                swap = {
                    enable = false,
                    -- swap_next = textobj_swap_keymaps,
                },
                -- move = textobj_move_keymaps,
                select = {
                    enable = false,
                    -- keymaps = textobj_sel_keymaps,
                },
            },
            textsubjects = {
                enable = false,
                keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
            },
            playground = {
                enable = false,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_nodes = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
            rainbow = {
                enable = true,
                extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
                colors = {
                    "#4EC9B0",
                    "#61AFEF",
                    "#b16286",
                    "#d79921",
                    "#689d6a",
                    "#d65d0e",
                    "#458588",
                },
                -- -- Syntax colors
                -- vscGray = '#808080',
                -- vscViolet = '#646695',
                -- vscBlue = '#61AFEF',
                -- vscDarkBlue = '#223E55',
                -- vscMediumBlue = '#18a2fe',
                -- vscLightBlue = '#9CDCFE',
                -- vscGreen = '#98C379',
                -- vscBlueGreen = '#4EC9B0',
                -- vscLightGreen = '#B5CEA8',
                -- vscRed = '#D26771',
                -- vscOrange = '#CE9178',
                -- vscLightRed = '#D16969',
                -- vscYellowOrange = '#D7BA7D',
                -- vscYellow = '#DCDCAA',
                -- vscPink = '#C678DD',

            },
        })
    end
end

return M
