-- nvim-dap is the main spec so the dap-ui listeners are registered however dap gets loaded
-- (keys below, or nvim-java requiring it when jdtls attaches).
local function dap(fn)
    return function()
        require("dap")[fn]()
    end
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        { "<leader>tb", dap("toggle_breakpoint"), desc = "Toggle breakpoint" },
        { "<leader>bc", function() require("dapui").close() end, desc = "Close debug UI" },
        { "<F5>", dap("continue"), desc = "Debug: continue" },
        { "<F7>", dap("step_into"), desc = "Debug: step into" },
        { "<F8>", dap("step_over"), desc = "Debug: step over" },
        { "<F9>", dap("step_out"), desc = "Debug: step out" },
        { "<F10>", dap("run_last"), desc = "Debug: run last" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            }
        }

        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
            }
        }

        dapui.setup({})
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
