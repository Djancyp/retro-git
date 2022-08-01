local status_ok, lspconfig = pcall(require, "lspconfig")
if status_ok then
    local handlers = require "configs.lsp.handlers"
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local status_ok, mason = pcall(require, "mason")
    if not status_ok then
        return
    end

    local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status_ok_1 then
        return
    end

    handlers.setup()
    local servers = mason_lspconfig.get_installed_servers()
    local settings = {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "◍",
                package_pending = "◍",
                package_uninstalled = "◍",
            },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    }

    mason.setup(settings)
    mason_lspconfig.setup {
        ensure_installed = servers,
        automatic_installation = true,
    }

    for _, server in ipairs(servers) do
        lspconfig[server].setup({
            capabilities = capabilities,
        })
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
