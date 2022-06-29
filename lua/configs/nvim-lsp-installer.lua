local M = {}

function M.config()
    local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
    if status_ok then
        lsp_installer.setup({
            automatic_installation = true,

        })
    end
end

return M
