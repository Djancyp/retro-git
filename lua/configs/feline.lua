if not pcall(require, "feline") then
    return
end

local colors = {
    bg = '#ebdbb2',
    fg = '#abb2bf',
    yellow = '#FAD02C',
    cyan = '#56b6c2',
    darkblue = '#333652',
    green = '#FFFFFF',
    orange = '#ED885C',
    violet = '#D4F1F4',
    magenta = '#c678dd',
    blue = '#83a598',
    red = '#e86671'
}
colors.bg = "#262626"
colors.bg2 = "#373737"
colors.fg = "#ffffff"
colors.red = "#f44747"
colors.green = "#4EC9B0"
colors.blue = "#0a7aca"
colors.lightblue = "#5CB6F8"
-- colors.yellow = "#ffaf00"
colors.pink = "#DDB6F2"

local vi_mode_colors = {
    NORMAL = colors.blue,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.red,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}


local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

-- get filetype
local vi_mode_utils = require 'feline.providers.vi_mode'


-- LuaFormatter off

local comps = {
    vi_mode = {
        left = {
            provider = function()
                return ' ' .. vi_mode_utils.get_vim_mode() .. ' '
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = "#ffffff",
                    bg = vi_mode_utils.get_mode_color(),
                    style = "bold"
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        },
        right = {
            provider = '▊',
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                }
                return val
            end,
        }
    },
    file = {
        info = {
            provider = {
                name = 'file_info',
                opts = {
                    type = 'relative-short',
                    file_readonly_icon = '  ',
                    -- file_readonly_icon = '  ',
                    -- file_readonly_icon = '  ',
                    -- file_readonly_icon = '  ',
                    -- file_modified_icon = '',
                    file_modified_icon = '',
                    -- file_modified_icon = 'ﱐ',
                    -- file_modified_icon = '',
                    -- file_modified_icon = '',
                    -- file_modified_icon = '',
                }
            },
            hl = {
                bg = colors.bg,
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold',
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.green,
            bg = colors.bg,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            provider = 'diagnostic_errors',
            hl = {
                fg = colors.red
            }
        },
        warn = {
            provider = 'diagnostic_warnings',
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            provider = 'diagnostic_info',
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            provider = 'diagnostic_hints',
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = function()
                local clients = vim.lsp.buf_get_clients()
                local client_names = {}

                -- add client
                for _, client in pairs(clients) do
                    if client.name ~= "copilot" and client.name ~= "null-ls" then
                        table.insert(client_names, client.name)
                    end
                end
                local client_names_str = table.concat(client_names, ", ")
                return client_names_str
            end,
            -- left_sep = ' ',
            right_sep = ' ',
            -- icon = '  ',
            icon = '慎',
            hl = {
                fg = colors.white,
                style = "bold"
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            -- icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold',
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    },
    spacer = {
        provider = string.rep(' ', 2)
    },
}

local components = {
    active = {},
    inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.spacer)
table.insert(components.active[3], comps.lsp.name)
-- table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)


require 'feline'.setup { disable = { filetypes = { "^NvimTree$", "^neo%-tree$", "^dashboard$", "^Outline$", "^aerial$",
    "packer", "alpha", "toggleterm" } },
    components = components,
    theme = {
        bg = colors.bg,
        black = '#1B1B1B',
        skyblue = '#50B0F0',
        cyan = '#009090',
        fg = '#D0D0D0',
        green = '#60A040',
        oceanblue = '#0066cc',
        magenta = '#C26BDB',
        orange = '#FF9000',
        red = '#D10000',
        violet = '#9E93E8',
        white = '#FFFFFF',
        yellow = '#E1E120',
    },
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = { 'terminal' },
        bufnames = {}
    }
}
