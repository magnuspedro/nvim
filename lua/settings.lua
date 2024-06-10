vim.opt.mouse = ""
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.spelllang = "en_us,pt_br"
vim.opt.spell = true

-- Better window navigation
vim.keymap.set("n", "<c-h>", "<c-w>h", { silent = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { silent = true })
vim.keymap.set("n", "<c-k>", "<c-k>k", { silent = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { silent = true })

-- Got to previus insert
vim.keymap.set("n", "<leader>.", "`.")

-- Copy the rest of line
vim.keymap.set("n", "Y", "y$")

-- Delete without save
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("n", "<leader>p", '"_dP')

-- Add ; and . at end of file
vim.keymap.set("n", "<leader>;", "A;<Esc>")
vim.keymap.set("n", "<leader>,", "A,<Esc>")

vim.keymap.set({ "n", "v" }, "<leader>q", ":bp!<bar>sp!<bar>bn!<bar>bd!<CR>")
vim.keymap.set({ "n", "v" }, "<leader>n", ":bnext<CR>")
vim.keymap.set({ "n", "v" }, "<leader>p", ":bprev<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.cmd("autocmd BufLeave,FocusLost * silent! wall")

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
})
