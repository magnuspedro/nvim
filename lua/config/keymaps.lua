local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<leader>.", "`.", { desc = "Go to last change" })
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Delete / paste without overwriting the register
map("n", "<leader>d", '"_d', { desc = "Delete without yank" })
map("n", "<leader>x", '"_x', { desc = "Delete char without yank" })
map("v", "<leader>p", '"_dP', { desc = "Paste without yank" })

map("n", "<leader>;", "A;<Esc>", { desc = "Add ; at end of line" })
map("n", "<leader>,", "A,<Esc>", { desc = "Add , at end of line" })

map({ "n", "v" }, "<leader>q", "<cmd>bp!<bar>sp!<bar>bn!<bar>bd!<cr>", { desc = "Close buffer, keep window" })
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>p", "<cmd>bprev<cr>", { desc = "Previous buffer" })
