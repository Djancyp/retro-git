local M = {}

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
function M.config()
    dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js' },
    }
    dap.configurations.javascript = {
        {
            name = 'Launch',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = 'Attach to process',
            type = 'node2',
            request = 'attach',
            processId = require 'dap.utils'.pick_process,
        }
    }
    dap.configurations.rust = {
        adapter = {
            type = "executable",
            command = "lldb-vscode-13",
            name = "rt_lldb",
        },
    }
    -- require('dap').set_log_level('INFO')
    dap.defaults.fallback.terminal_win_cmd = '20split new'
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = 'ﰸ', texthl = 'Error', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
    -- nvim-telescope/telescope-dap.nvim
end

function M.attach()
    print("attaching")
    dap.run({
        type = 'node2',
        request = 'attach',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = { '<node_internals>/**/*.js' },
    })
end

function M.attachToRemote()
    print("attaching")
    dap.run({
        type = 'node2',
        request = 'attach',
        address = "127.0.0.1",
        port = 9229,
        localRoot = vim.fn.getcwd(),
        remoteRoot = "/home/vcap/app",
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = { '<node_internals>/**/*.js' },
    })
end

return M
