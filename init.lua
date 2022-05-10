local utils = require("core.utils")
utils.bootstrap()
local sources = {
  "core.options",
  "core.plugins",
  "core.mappings",
  "configs.which-key-register",
  "core.autocmds",
}

for _, source in ipairs(sources) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    error("Failed to load " .. source .. "\n\n" .. fault)
  elseif source == "core.plugins" then
    utils.compiled()
  end
end

local status_ok, ui = pcall(require, "core.ui")
if status_ok then
  for ui_addition, enabled in pairs(utils.user_plugin_opts("ui", { nui_input = true, telescope_select = true })) do
    if enabled and type(ui[ui_addition]) == "function" then
      ui[ui_addition]()
    end
  end
end
