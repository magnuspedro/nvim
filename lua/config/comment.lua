require('nvim_comment').setup()

vim.keymap.set({'n','v'}, '<c-_>', ':CommentToggle<CR>', { silent = true })
