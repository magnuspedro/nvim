local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end


map("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>")
map("n", "<leader>cct", "<cmd>CopilotChatTests<cr>")
map("x", "<leader>ccv", ":CopilotChatVisual")
map("x", "<leader>ccx", ":CopilotChatInPlace<cr>")
