local dap = require("dap")
-- require('dap').defaults.kotlin.auto_continue_if_many_stopped = false
-- Adapter configuration
dap.adapters.kotlin = {
	type = "executable",
	command = "/home/marcelo/.local/share/nvim/mason/packages/kotlin-debug-adapter/adapter/bin/kotlin-debug-adapter",
	args = { "--interpreter=vscode" },
}

-- Configuration
dap.configurations.kotlin = {
	{
		type = "kotlin",
		name = "launch - kotlin",
		request = "launch",
		projectRoot = vim.fn.getcwd() .. "/app",
		mainClass = function()
			-- return vim.fn.input("Path to main class > ", "myapp.sample.app.AppKt", "file")
			return vim.fn.input("Path to main class > ", "", "file")
		end,
	},
}

