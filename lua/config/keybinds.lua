local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Better window navegation
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Got to previus insert
map('n', '<leader>.', '`.')

-- Copy the rest of line
map('n', 'Y', 'y$')

-- Delete without save
map('n', '<leader>d', '"_d')
map('n', '<leader>x', '"_x')

-- Add ; and . at end of file
map('n', '<leader>;', 'A;<Esc>')
map('n', '<leader>,', 'A,<Esc>')
