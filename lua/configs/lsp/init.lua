local status_ok, lspconfig = pcall(require, "lspconfig")
if status_ok then
    local handlers = require "configs.lsp.handlers"
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    handlers.setup()
    local servers = {}
    local installer_avail, lsp_installer = pcall(require, "nvim-lsp-installer")
    if installer_avail then
        for _, server in ipairs(lsp_installer.get_installed_servers()) do
            table.insert(servers, server.name)
            lspconfig[server.name].setup({
                capabilities = capabilities,
            })
        end
    end
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.format()
        end,
    })
end
