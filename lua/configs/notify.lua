local M = {}

function M.config()
    local present, notify = pcall(require, "notify")
    if present then
        notify.setup(require("core.utils").user_plugin_opts("plugins.notify", {
            background_colour = "#000000",
            stages = "fade",
        }))
        vim.notify = notify
    end
end

return M
