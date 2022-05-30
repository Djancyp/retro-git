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

augroup("dashboard_settings", {})

cmd("FileType", {
  desc = "Disable tabline for dashboard",
  group = "dashboard_settings",
  pattern = "dashboard",
  command = "set showtabline=0",
})
cmd("BufWinLeave", {
  desc = "Reenable tabline when leaving dashboard",
  group = "dashboard_settings",
  pattern = "<buffer>",
  command = "set showtabline=0",
})
cmd("FileType", {
  desc = "Disable statusline for dashboard",
  group = "dashboard_settings",
  pattern = "dashboard",
  command = "set laststatus=0 | IndentBlanklineDisable",
})
cmd("BufWinLeave", {
  desc = "Reenable statusline when leaving dashboard",
  group = "dashboard_settings",
  pattern = "<buffer>",
  command = "set laststatus=3",
})
create_command("ToggleHighlightURL", require("core.utils").toggle_url_match, { desc = "Toggle URL Highlights" })
