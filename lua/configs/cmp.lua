local M = {}
function M.config()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if cmp_status_ok then
        -- Setup lspconfig.
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        -- -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        local lspconfig = require('lspconfig')
        local servers = { 'sumneko_lua', 'cssls', 'tailwindcss', 'tsserver', 'vuels', 'html', 'volar', 'bashls', 'rust_analyzer' }
        for _, lsp in ipairs(servers) do
            if lsp == "rust_analyzer" then
                -- local rust_opts = require "user.lsp.settings.rust"
                local rust_opts = {
                    tools = {
                        on_initialized = function()
                            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                                pattern = { "*.rs" },
                                callback = function()
                                    vim.lsp.codelens.refresh()
                                end,
                            })
                        end,
                        inlay_hints = {
                            parameter_hints_prefix = " ",
                            other_hints_prefix = " ",
                        },
                    },

                    dap = {
                        adapter = {
                            type = "executable",
                            command = "lldb-vscode-13",
                            name = "rt_lldb",
                        },
                    },
                    hover_actions = {
                        -- the border that is used for the hover window
                        -- see vim.api.nvim_open_win()
                        border = {
                            { "╭", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╮", "FloatBorder" },
                            { "│", "FloatBorder" },
                            { "╯", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╰", "FloatBorder" },
                            { "│", "FloatBorder" },
                        },

                        -- whether the hover action window gets automatically focused
                        -- default: false
                        auto_focus = false,
                    },

                    server = {
                        on_attach = require("configs.lsp.handlers").on_attach,
                        capabilities = require("configs.lsp.handlers").capabilities,

                        settings = {
                            ["rust-analyzer"] = {
                                lens = {
                                    enable = true,
                                },
                                checkOnSave = {
                                    command = "clippy",
                                },
                            },
                        },
                    },

                }
                --
                local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
                if not rust_tools_status_ok then
                    return
                end
                --
                rust_tools.setup(rust_opts)
                goto continue
            end
            lspconfig[lsp].setup {
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
                -- vim.lsp.codelens.refresh()
            }

            ::continue::
        end
        local kind_icons = {
            Class = " ",
            Color = " ",
            Constant = "ﲀ ",
            Constructor = " ",
            Enum = "練",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = "",
            Folder = " ",
            Function = " ",
            Interface = "ﰮ ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Operator = "",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = "塞",
            Value = " ",
            Variable = " ",
        }
        local source_names = {
            nvim_lsp = "(LSP)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            vsnip = "(Snippet)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
            tmux = "(TMUX)",
        }
        local duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
        }
        cmp.setup({
            preselect = cmp.PreselectMode.None,
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local max_width = 30
                    if max_width ~= 0 and #vim_item.abbr > max_width then
                        vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
                    end
                    vim_item.kind = kind_icons[vim_item.kind]
                    vim_item.menu = source_names[entry.source.name]
                    vim_item.dup = duplicates[entry.source.name]
                        or 0
                    return vim_item
                end, },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            duplicates_default = 0,
            completion = {
                ---@usage The minimum length of a word to complete on.
                keyword_length = 1,
            },
            experimental = {
                ghost_text = true,
                native_menu = false,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "luasnip" },
                { name = "cmp_tabnine" },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "calc" },
                { name = "emoji" },
                { name = "treesitter" },
                { name = "crates" },
                { name = "tmux" },
            }, mapping = {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable,
                ["<C-e>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                },
                ["<CR>"] = cmp.mapping.confirm { select = true },
                ["<C-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },
        })
    end
end

return M
