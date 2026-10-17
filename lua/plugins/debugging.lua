-- nvim-dap is the main spec so nvim-dap-view is set up however dap gets loaded
-- (keys below, or nvim-java requiring it when jdtls attaches).
local function dap(fn)
    return function() require("dap")[fn]() end
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "igorlfs/nvim-dap-view",
            version = "1.*",
            ---@module "dap-view"
            ---@type dapview.Config
            opts = {
                auto_toggle = true, -- open when a session starts, close when it ends
                virtual_text = { enabled = true }, -- inline variable values, like IntelliJ
            },
        },
    },
    keys = {
        { "<leader>tb", dap("toggle_breakpoint"), desc = "Toggle breakpoint" },
        { "<leader>bv", "<cmd>DapViewToggle<cr>", desc = "Toggle debug view" },
        { "<leader>bc", "<cmd>DapViewClose<cr>", desc = "Close debug view" },
        { "<F5>", dap("continue"), desc = "Debug: continue" },
        { "<F7>", dap("step_into"), desc = "Debug: step into" },
        { "<F8>", dap("step_over"), desc = "Debug: step over" },
        { "<F9>", dap("step_out"), desc = "Debug: step out" },
        { "<F10>", dap("run_last"), desc = "Debug: run last" },
    },
    config = function()
        local dap = require("dap")

        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
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
            },
        }
    end,
}
