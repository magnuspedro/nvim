local g = vim.g
local o = vim.o

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Better UI
o.number = true
o.numberwidth = 1
o.relativenumber = true

-- Map <leader>
g.mapleader = ' '
g.maplocalleader = ' '

-- Config gruvbox
o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Better editing experience
o.expandtab = true
-- o.smarttab = true
o.cindent = true
-- o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
