local M = {}

local utils = require "core.utils"

local map = vim.keymap.set
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
-- set copilot to use Ctrl-L as leader key
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
map("i", "<C-l>", "copilot#Accept()", { expr = true, silent = true })
-- map for formatting
map("v", "fr", ":lua require'lsp-range-format'.format()<CR>")
-- Normal --
-- Better window navigation
map("n", "<C-h>", function()
    require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
map("n", "<C-j>", function()
    require("smart-splits").move_cursor_down()
end, { desc = "Move to below split" })
map("n", "<C-k>", function()
    require("smart-splits").move_cursor_up()
end, { desc = "Move to above split" })
map("n", "<C-l>", function()
    require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })

-- Resize with arrows
map("n", "<C-Up>", function()
    require("smart-splits").resize_up()
end, { desc = "Resize split up" })
map("n", "<C-Down>", function()
    require("smart-splits").resize_down()
end, { desc = "Resize split down" })
map("n", "<C-Left>", function()
    require("smart-splits").resize_left()
end, { desc = "Resize split left" })
map("n", "<C-Right>", function()
    require("smart-splits").resize_right()
end, { desc = "Resize split right" })

-- Navigate buffers
if utils.is_available "bufferline.nvim" then
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
    map("n", "}", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
    map("n", "{", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })
else
    map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
    map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
end

-- buffer-tab
map("n", "<S-C>", "<cmd>BSOpen<CR>", { desc = "Next buffer tab" })
-- LSP
map("n", "K", vim.lsp.buf.hover, { desc = "Hover symbol details" })
-- <leader>rn: legacy binding here for backwards compatibility but not in which-key (see <leader>lr)
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename current symbol" })

-- ForceWrite
map("n", "<C-s>", "<cmd>w!<CR>", { desc = "Force write" })

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>", { desc = "Force quit" })

-- Terminal
map("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- disable Ex mode:
map("n", "Q", "<Nop>")

-- Harpon keymappings.
map("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
map("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
-- map("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
-- map("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
-- map("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
-- Normal Leader Mappings --
-- NOTICE: if changed, update configs/which-key-register.lua
-- Allows easy user modifications when just overriding which-key
-- But allows bindings to work for users without which-key
if not utils.is_available "which-key.nvim" then
    -- Standard Operations
    map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
    map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quite" })
    map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Disable search highlight" })
    map("n", "<leader>u", require("core.utils").toggle_url_match, { desc = "Toggle URL Highlights" })

    if utils.is_available "vim-bbye" then
        map("n", "<leader>c", "<cmd>Bdelete!<CR>", { desc = "Delete buffer" })
    end

    -- Packer
    map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer compile" })
    map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer install" })
    map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer sync" })
    map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer status" })
    map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer update" })

    -- LSP
    map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
    map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
    map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })
    map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename current symbol" })
    map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration of current symbol" })
    map("n", "gd", vim.lsp.buf.definition, { desc = "Show the definition of current symbol" })
    map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation of current symbol" })
    map("n", "gr", vim.lsp.buf.references, { desc = "References of current symbol" })
    map("n", "go", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
    map("n", "gl", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    map("n", "gk", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    map("n", "gj", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    map("n", "gx", utils.url_opener_cmd(), { desc = "Open the file under cursor with system app" })
    map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Open the file under cursor with system app" })

    -- NeoTree
    if utils.is_available "neo-tree.nvim" then
        map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-Tree" })
        map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Focus Neo-Tree" })
    end

    -- Dashboard
    map("n", "<leader>fn", "<cmd>ver new<CR>", { desc = "New File" })
    map("n", "<leader>Sl", "<cmd>SessionLoad<CR>", { desc = "Load session" })
    map("n", "<leader>Ss", "<cmd>SessionSave<CR>", { desc = "Save session" })

    -- GitSigns
    if utils.is_available "gitsigns.nvim" then
        map("n", "<leader>gj", function()
            require("gitsigns").next_hunk()
        end, { desc = "Next git hunk" })
        map("n", "<leader>gk", function()
            require("gitsigns").prev_hunk()
        end, { desc = "Previous git hunk" })
        map("n", "<leader>gl", function()
            require("gitsigns").blame_line()
        end, { desc = "View git blame" })
        map("n", "<leader>gp", function()
            require("gitsigns").preview_hunk()
        end, { desc = "Preview git hunk" })
        map("n", "<leader>gh", function()
            require("gitsigns").reset_hunk()
        end, { desc = "Reset git hunk" })
        map("n", "<leader>gr", function()
            require("gitsigns").reset_buffer()
        end, { desc = "Reset git buffer" })
        map("n", "<leader>gs", function()
            require("gitsigns").stage_hunk()
        end, { desc = "Stage git hunk" })
        map("n", "<leader>gu", function()
            require("gitsigns").undo_stage_hunk()
        end, { desc = "Unstage git hunk" })
        map("n", "<leader>gd", function()
            require("gitsigns").diffthis()
        end, { desc = "View git diff" })
    end

    -- Telescope
    if utils.is_available "telescope.nvim" then
        map("n", "<leader>fw", function()
            require("telescope.builtin").live_grep()
        end, { desc = "Telescope search words" })
        map("n", "<leader>gt", function()
            require("telescope.builtin").git_status()
        end, { desc = "Telescope git status" })
        map("n", "<leader>gb", function()
            require("telescope.builtin").git_branches()
        end, { desc = "Telescope git branchs" })
        map("n", "<leader>gc", function()
            require("telescope.builtin").git_commits()
        end, { desc = "Telescope git commits" })
        map("n", "<leader>ff", function()
            require("telescope.builtin").find_files()
        end, { desc = "Telescope search files" })
        map("n", "<leader>fb", function()
            require("telescope.builtin").buffers()
        end, { desc = "Telescope search buffers" })
        map("n", "<leader>fh", function()
            require("telescope.builtin").help_tags()
        end, { desc = "Telescope search help" })
        map("n", "<leader>fm", function()
            require("telescope.builtin").marks()
        end, { desc = "Telescope search marks" })
        map("n", "<leader>fo", function()
            require("telescope.builtin").oldfiles()
        end, { desc = "Telescope search history" })
        map("n", "<leader>sb", function()
            require("telescope.builtin").git_branches()
        end, { desc = "Telescope git branchs" })
        map("n", "<leader>sh", function()
            require("telescope.builtin").help_tags()
        end, { desc = "Telescope search help" })
        map("n", "<leader>sm", function()
            require("telescope.builtin").man_pages()
        end, { desc = "Telescope search man" })
        map("n", "<leader>sn", function()
            require("telescope").extensions.notify.notify()
        end, { desc = "Telescope search notifications" })
        map("n", "<leader>sr", function()
            require("telescope.builtin").registers()
        end, { desc = "Telescope search registers" })
        map("n", "<leader>sk", function()
            require("telescope.builtin").keymaps()
        end, { desc = "Telescope search keymaps" })
        map("n", "<leader>sc", function()
            require("telescope.builtin").commands()
        end, { desc = "Telescope search commands" })
        map("n", "<leader>ls", function()
            require("telescope.builtin").lsp_document_symbols()
        end, { desc = "Telescope search symbols" })
        map("n", "<leader>lR", function()
            require("telescope.builtin").lsp_references()
        end, { desc = "Telescope search references" })
        map("n", "<leader>lD", function()
            require("telescope.builtin").diagnostics()
        end, { desc = "Telescope search diagnostics" })
    end

    -- Comment
    if utils.is_available "Comment.nvim" then
        map("n", "<leader>/", function()
            require("Comment.api").toggle_current_linewise()
        end, { desc = "Toggle comment line" })
    end

    -- Terminal
    if utils.is_available "nvim-toggleterm.lua" then
        map("n", "<leader>gg", function()
            utils.toggle_term_cmd "lazygit"
        end, { desc = "ToggleTerm lazygit" })
        map("n", "<leader>tn", function()
            utils.toggle_term_cmd "node"
        end, { desc = "ToggleTerm node" })
        map("n", "<leader>tu", function()
            utils.toggle_term_cmd "ncdu"
        end, { desc = "ToggleTerm NCDU" })
        map("n", "<leader>tt", function()
            utils.toggle_term_cmd "htop"
        end, { desc = "ToggleTerm htop" })
        map("n", "<leader>tp", function()
            utils.toggle_term_cmd "python"
        end, { desc = "ToggleTerm python" })
        map("n", "<leader>tl", function()
            utils.toggle_term_cmd "lazygit"
        end, { desc = "ToggleTerm lazygit" })
        map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
        map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
        map("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
    end

    -- SymbolsOutline
    if utils.is_available "aerial.nvim" then
        map("n", "<leader>lS", "<cmd>AerialToggle<CR>", { desc = "Symbols outline" })
    end
end

-- vimspector keymaps
if utils.is_available "vimspector.nvim" then
    map("n", "<leader>Ds", "<cmd>:call vimspector#Launc()<CR>", { desc = "Vimspector" })
end

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<CR>==", { desc = "move text down" })
map("v", "<A-k>", "<cmd>m .-2<CR>==", { desc = "move text up" })

-- Comment
if utils.is_available "Comment.nvim" then
    map(
        "v",
        "<leader>/",
        "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
        { desc = "Toggle comment line" }
    )
end
-- Debugger
vim.keymap.set('n', '<leader>dh', function() require "dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<leader>dkk', function() require "dap".step_out() end)
vim.keymap.set('n', "<leader>dll", function() require "dap".step_into() end)
vim.keymap.set('n', '<leader>djj', function() require "dap".step_over() end)
vim.keymap.set('n', '<leader>dhh', function() require "dap".continue() end)
vim.keymap.set('n', '<leader>dn', function() require "dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require "dap".terminate() end)
vim.keymap.set('n', '<leader>dR', function() require "dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de', function() require "dap".set_exception_breakpoints({ "all" }) end)
vim.keymap.set('n', '<leader>da', function() require "configs.dap".attach() end)
vim.keymap.set('n', '<leader>dA', function() require "configs.dap".attachToRemote() end)
vim.keymap.set('n', '<leader>di', function() require "dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<leader>ds', ':lua require"telescope".extensions.dap.frames{}<CR>')
-- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
function _G.set_terminal_keymaps()
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
    vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], { desc = "Terminal left window navigation" })
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], { desc = "Terminal down window navigation" })
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], { desc = "Terminal up window navigation" })
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], { desc = "Terminal right window naviation" })
end

augroup("TermMappings", {})
cmd("TermOpen", {
    desc = "Set terminal keymaps",
    group = "TermMappings",
    callback = _G.set_terminal_keymaps,
})

return M
