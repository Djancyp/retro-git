local M = {}

local utils = require "core.utils"
local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local mappings = {
        n = {
            ["<leader>"] = {
                ["w"] = { "<cmd>w<CR>", "Save" },
                ["q"] = { "<cmd>q<CR>", "Quit" },
                ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
                ["u"] = { require("core.utils").toggle_url_match, "Toggle URL Highlights" },

                p = {
                    name = "Packer",
                    c = { "<cmd>PackerCompile<cr>", "Compile" },
                    i = { "<cmd>PackerInstall<cr>", "Install" },
                    s = { "<cmd>PackerSync<cr>", "Sync" },
                    S = { "<cmd>PackerStatus<cr>", "Status" },
                    u = { "<cmd>PackerUpdate<cr>", "Update" },
                },

                l = {
                    name = "LSP",
                    a = { vim.lsp.buf.code_action, "Code Action" },
                    d = { vim.diagnostic.open_float, "Hover Diagnostic" },
                    f = { vim.lsp.buf.format, "Format" },
                    i = { "<cmd>LspInfo<cr>", "Info" },
                    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
                    r = { vim.lsp.buf.rename, "Rename" },
                    h = { vim.lsp.buf.hover, "Hover" }
                },
                h = {
                    name = "Harpon",
                    a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Mark buffer" },
                    t = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "toggle harpon" },
                    n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "next buffer" },
                    p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "next buffer" },
                }
            },
            g = {
                d = { vim.lsp.buf.definition, "Go to definition" },
                D = { vim.lsp.buf.declaration, "Go to declaration" },
                I = { vim.lsp.buf.implementation, "Go to implementation" },
                r = { vim.lsp.buf.references, "Go to references" },
                o = { vim.diagnostic.open_float, "Hover diagnostic" },
                l = { vim.diagnostic.open_float, "Hover diagnostic" },
                k = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
                j = { vim.diagnostic.goto_next, "Go to next diagnostic" },
                x = { utils.url_opener_cmd(), "Open the file under cursor with system app" },
            },
            ["["] = {
                d = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
            },
            ["]"] = {
                d = { vim.diagnostic.goto_next, "Go to next diagnostic" },
            },
        },
    }

    local extra_sections = {
        f = "File",
        g = "Git",
        l = "LSP",
        s = "Search",
        t = "Terminal",
        S = "Session",
    }

    local function init_table(mode, prefix, idx)
        if not mappings[mode][prefix][idx] then
            mappings[mode][prefix][idx] = { name = extra_sections[idx] }
        end
    end

    mappings.n["<leader>"].e = { "<cmd>Neotree toggle<CR>", "Toggle Explorer" }
    mappings.n["<leader>"].o = { "<cmd>Neotree focus<CR>", "Focus Explorer" }


    init_table("n", "<leader>", "f")
    mappings.n["<leader>"].f.n = { "<cmd>:vert new<CR>", "New File" }

    init_table("n", "<leader>", "S")
    mappings.n["<leader>"].S.s = { "<cmd>SessionSave<CR>", "Save Session" }
    mappings.n["<leader>"].S.l = { "<cmd>SessionLoad<CR>", "Load Session" }

    mappings.n["<leader>"]["/"] = {
        function()
            require("Comment.api").toggle_current_linewise()
        end,
        "Comment",
    }

    mappings.n["<leader>"].c = { "<cmd>Bdelete!<CR>", "Close Buffer" }

    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.j = {
        function()
            require("gitsigns").next_hunk()
        end,
        "Next Hunk",
    }
    mappings.n["<leader>"].g.B = {
        function()
            require("gitsigns").blame_line()
        end,
        "Blame Line",
    }
    mappings.n["<leader>"].g.k = {
        function()
            require("gitsigns").prev_hunk()
        end,
        "Prev Hunk",
    }
    mappings.n["<leader>"].g.l = {
        function()
            require("gitsigns").blame_line()
        end,
        "Blame",
    }
    mappings.n["<leader>"].g.p = {
        function()
            require("gitsigns").preview_hunk()
        end,
        "Preview Hunk",
    }
    mappings.n["<leader>"].g.h = {
        function()
            require("gitsigns").reset_hunk()
        end,
        "Reset Hunk",
    }
    mappings.n["<leader>"].g.r = {
        function()
            require("gitsigns").reset_buffer()
        end,
        "Reset Buffer",
    }
    mappings.n["<leader>"].g.s = {
        function()
            require("gitsigns").stage_hunk()
        end,
        "Stage Hunk",
    }
    mappings.n["<leader>"].g.u = {
        function()
            require("gitsigns").undo_stage_hunk()
        end,
        "Undo Stage Hunk",
    }
    mappings.n["<leader>"].g.d = {
        function()
            require("gitsigns").diffthis()
        end,
        "Diff",
    }

    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.g = {
        function()
            require("core.utils").toggle_term_cmd "lazygit"
        end,
        "Lazygit",
    }

    init_table("n", "<leader>", "t")
    mappings.n["<leader>"].t.n = {
        function()
            require("core.utils").toggle_term_cmd "node"
        end,
        "Node",
    }
    mappings.n["<leader>"].t.u = {
        function()
            require("core.utils").toggle_term_cmd "ncdu"
        end,
        "NCDU",
    }
    mappings.n["<leader>"].t.t = {
        function()
            require("core.utils").toggle_term_cmd "htop"
        end,
        "Htop",
    }
    mappings.n["<leader>"].t.p = {
        function()
            require("core.utils").toggle_term_cmd "python"
        end,
        "Python",
    }
    mappings.n["<leader>"].t.l = {
        function()
            require("core.utils").toggle_term_cmd "lazygit"
        end,
        "Lazygit",
    }
    mappings.n["<leader>"].t.f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }
    mappings.n["<leader>"].t.h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }
    mappings.n["<leader>"].t.v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }

    init_table("n", "<leader>", "l")
    mappings.n["<leader>"].l.S = { "<cmd>AerialToggle<CR>", "Symbols Outline" }

    init_table("n", "<leader>", "s")
    mappings.n["<leader>"].s.b = {
        function()
            require("telescope.builtin").git_branches()
        end,
        "Checkout branch",
    }
    mappings.n["<leader>"].s.h = {
        function()
            require("telescope.builtin").help_tags()
        end,
        "Find Help",
    }
    mappings.n["<leader>"].s.m = {
        function()
            require("telescope.builtin").man_pages()
        end,
        "Man Pages",
    }
    mappings.n["<leader>"].s.n = {
        function()
            require("telescope").extensions.notify.notify()
        end,
        "Notifications",
    }
    mappings.n["<leader>"].s.r = {
        function()
            require("telescope.builtin").registers()
        end,
        "Registers",
    }
    mappings.n["<leader>"].s.k = {
        function()
            require("telescope.builtin").keymaps()
        end,
        "Keymaps",
    }
    mappings.n["<leader>"].s.c = {
        function()
            require("telescope.builtin").commands()
        end,
        "Commands",
    }

    init_table("n", "<leader>", "g")
    mappings.n["<leader>"].g.t = {
        function()
            require("telescope.builtin").git_status()
        end,
        "Open changed file",
    }
    mappings.n["<leader>"].g.b = {
        function()
            require("telescope.builtin").git_branches()
        end,
        "Checkout branch",
    }
    mappings.n["<leader>"].g.c = {
        function()
            require("telescope.builtin").git_commits()
        end,
        "Checkout commit",
    }

    init_table("n", "<leader>", "f")
    mappings.n["<leader>"].f.b = {
        function()
            require("telescope.builtin").buffers()
        end,
        "Find Buffers",
    }
    mappings.n["<leader>"].f.f = {
        function()
            require("telescope.builtin").find_files()
            --[[ require 'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 10 })) ]]
            --[[ require 'telescope.builtin'.find_files(require('telescope.themes').get_cursor()) ]]
            --[[ require 'telescope.builtin'.find_files(require('telescope.themes').get_ivy()) ]]
        end,
        "Find Files",
    }
    mappings.n["<leader>"].f.h = {
        function()
            require("telescope.builtin").help_tags()
        end,
        "Find Help",
    }
    mappings.n["<leader>"].f.m = {
        function()
            require("telescope.builtin").marks()
        end,
        "Find Marks",
    }
    mappings.n["<leader>"].f.o = {
        function()
            require("telescope.builtin").oldfiles()
        end,
        "Find Old Files",
    }
    mappings.n["<leader>"].f.w = {
        function()
            require("telescope.builtin").live_grep()
        end,
        "Find Words",
    }

    init_table("n", "<leader>", "l")
    mappings.n["<leader>"].l.s = {
        function()
            require("telescope.builtin").lsp_document_symbols()
        end,
        "Document Symbols",
    }
    mappings.n["<leader>"].l.R = {
        function()
            require("telescope.builtin").lsp_references()
        end,
        "References",
    }
    mappings.n["<leader>"].l.D = {
        function()
            require("telescope.builtin").diagnostics()
        end,
        "All Diagnostics",
    }

    mappings = require("core.utils").user_plugin_opts("which-key.register_mappings", mappings)
    -- support previous legacy notation, deprecate at some point
    mappings.n["<leader>"] = require("core.utils").user_plugin_opts("which-key.register_n_leader",
        mappings.n["<leader>"
        ])
    for mode, prefixes in pairs(mappings) do
        for prefix, mapping_table in pairs(prefixes) do
            which_key.register(mapping_table, {
                mode = mode,
                prefix = prefix,
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            })
        end
    end
end

return M
