local utils = require "core.utils"

local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local create_command = vim.api.nvim_create_user_command

augroup("highlighturl", { clear = true })
cmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
    desc = "URL Highlighting",
    group = "highlighturl",
    pattern = "*",
    callback = require("core.utils").set_url_match,
})
create_command("ToggleHighlightURL", require("core.utils").toggle_url_match, { desc = "Toggle URL Highlights" })
