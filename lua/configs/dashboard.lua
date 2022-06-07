local M = {}

function M.config()
  local present, alpha = pcall(require, "alpha")
  if present then
    -- local alpha_button = astronvim.alpha_button
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = {
      "██   ██   ████    █████    ██  ██  ",
      "██   ██  ██  ██   ██  ██   ██ ██   ",
      "██   ██  ██  ██   ██  ██   ████    ",
      "██ █ ██  ██  ██   █████    ███     ",
      "███████  ██  ██   ████     ████    ",
      "███ ███  ██  ██   ██ ██    ██ ██   ",
      "██   ██   ████    ██  ██   ██  ██  ",
      "                                   ",
      "██  ██     ██     █████    ████     ██████   █████   ",
      "██  ██    ████    ██  ██   ██ ██    ██       ██  ██  ",
      "██  ██   ██  ██   ██  ██   ██  ██   ██       ██  ██  ",
      "██████   ██████   █████    ██  ██   ████     █████   ",
      "██  ██   ██  ██   ████     ██  ██   ██       ████    ",
      "██  ██   ██  ██   ██ ██    ██ ██    ██       ██ ██   ",
      "██  ██   ██  ██   ██  ██   ████     ██████   ██  ██ ",
    }
    alpha.setup(dashboard.config)
  end
end

return M
