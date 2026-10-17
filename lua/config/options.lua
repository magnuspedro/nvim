-- Leader must be set before lazy.nvim loads so plugin mappings use it
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mouse = ""
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.spelllang = "en_us,pt_br"
vim.o.spell = true
-- Always show the sign column so git and diagnostic signs do not shift the text
vim.o.signcolumn = "yes"
-- Searches ignore case unless they contain an uppercase letter
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep 8 lines of context above / below the cursor
vim.o.scrolloff = 8
