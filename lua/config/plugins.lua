require("mason").setup()

return require('packer').startup(function()

	use 'ellisonleao/gruvbox.nvim'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
    use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}}
	use 'udalov/kotlin-vim'
    use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }
}   use 'mfussenegger/nvim-jdtls'

end)


