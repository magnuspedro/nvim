return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

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

        vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<F5>", dap.continue, {})
        vim.keymap.set("n", "<F7>", dap.step_into, {})
        vim.keymap.set("n", "<F8>", dap.step_over, {})
        vim.keymap.set("n", "<F9>", dap.step_out, {})
        vim.keymap.set("n", "<F10>", dap.run_last, {})
    end,
}
