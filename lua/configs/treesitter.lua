local M = {}

function M.config()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if status_ok then
        if #vim.api.nvim_list_uis() == 0 then
            return
        end
        treesitter.setup({
            on_config_done = nil,
            ensure_installed = { "http", "json", },
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
                use_languagetree = true,
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
            spellcheck = {
                enable = true,
                enable_autocmd = false,
            },
            autopairs = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
            },
            indent = { enable = true, disable = { "yaml", "python" } },
            rainbow = {
                enable = false,
                extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
            }, autotag = {
                enable = true,
            },
            diagnostics = {
                enable = false,
                show_on_dirs = false,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
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
        })
    end
end

return M
