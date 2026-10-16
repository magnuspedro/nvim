-- Save all buffers when leaving a buffer or Neovim loses focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    group = vim.api.nvim_create_augroup("user-autosave", { clear = true }),
    command = "silent! wall",
})
