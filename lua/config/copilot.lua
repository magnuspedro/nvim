local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

  -- vim.g.copilot_filetypes = {
  --   ["*"] = false,
  --   ["javascript"] = true,
  --   ["typescript"] = true,
  --   ["lua"] = true,
  --   ["rust"] = true,
  --   ["c"] = true,
  --   ["c#"] = true,
  --   ["c++"] = true,
  --   ["go"] = true,
  --   ["java"] = true,
  --   ["python"] = true,
  -- }


vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<space>cca", 'copilot#Accept("<CR>")', { silent = true, expr = true })

map("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>")
map("n", "<leader>cct", "<cmd>CopilotChatTests<cr>")
map("x", "<leader>ccv", ":CopilotChatVisual")
map("x", "<leader>ccx", ":CopilotChatInPlace<cr>")
