local null_ls = require("null-ls")
local M = {}

function M.setup()
    require("null-ls").setup({
        debug = false,
        sources = {
            -- null_ls.builtins.diagnostics.eslint.with({
            --   filetypes = {
            --     "javascriptreact",
            --     "typescript",
            --     "typescriptreact",
            --   },
            -- }),
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.formatting.prettier
        },
    })
end

return M
