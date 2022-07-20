local null_ls = require("null-ls")
local M = {}
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
function M.setup()
    require("null-ls").setup {
        debug = false,
        sources = {
            formatting.prettier.with {
                extra_filetypes = { "toml", "solidity" },
                extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            },
            formatting.black.with { extra_args = { "--fast" } },
            formatting.shfmt,
            diagnostics.flake8,
            diagnostics.shellcheck,
        },
    }
end

return M
