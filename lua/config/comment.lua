require('nvim_comment').setup()

vim.keymap.set('n', '<c-_>', ':CommentToggle<CR>', { silent = true })
