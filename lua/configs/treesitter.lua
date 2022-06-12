local M = {}

function M.config()
    local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if status_ok then
        treesitter.setup({
            ensure_installed = { "http", "json" },
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
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
            indent = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = false,
                max_file_lines = nil,
            },
            autotag = {
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
        })
    end
end

return M
