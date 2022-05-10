require("null-ls").setup({
  debug = false,
    sources = {
        require("null-ls").builtins.diagnostics.stylua
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end,
})
