-- Remap Function
local function map(m, k, v)
    vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

-- Debuggin
map("n", "<leader>tb", "<CMD>lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<F5>", "<CMD>lua require('dapui').open() require'dap'.continue()<CR>")
map("n", "<F7>", "<CMD>lua require'dap'.step_into()<CR>")
map("n", "<F8>", "<CMD>lua require'dap'.step_over()<CR>")
map("n", "<F9>", "<CMD>lua require'dap'.step_out()<CR>")
map("n", "<F10>", "<CMD>lua require'dap'.run_last()<CR>")
map("n", "<leader>dr", "<CMD>lua require'dap'.repl.open()<CR>")

-- Testing
map("n", "<leader>tm", "<CMD>lua require'jdtls'.test_nearest_method()<CR>")
map("n", "<leader>tc", "<CMD>lua require'jdtls'.test_class()<CR>")
