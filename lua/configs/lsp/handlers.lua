local M = {}
function M.setup()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config({
        virtual_text = true,
        signs = { active = signs },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_highlight_document(client)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            pattern = "<buffer>",
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            pattern = "<buffer>",
            callback = vim.lsp.buf.clear_references,
        })
    end
end

M.on_attach = function(client, bufnr)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover symbol details", buffer = 0 })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format code", buffer = 0 })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action", buffer = 0 })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename current symbol", buffer = 0 })
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Hover diagnostics", buffer = 0 })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename current symbol", buffer = 0 }) -- (DEPRECATED)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration of current symbol", buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current symbol", buffer = 0 })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation of current symbol", buffer = 0 })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References of current symbol", buffer = 0 })
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, { desc = "Format file with LSP" })

    if client.name == "tsserver" or client.name == "jsonls" or client.name == "html" or client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
    end

    local aerial_avail, aerial = pcall(require, "aerial")
    if aerial_avail then
        aerial.on_attach(client, bufnr)
    end
    lsp_highlight_document(client)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

return M
