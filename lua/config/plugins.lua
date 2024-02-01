return require('packer').startup(function()
    use { "ellisonleao/gruvbox.nvim" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, file_ignore_patterns = {
        "node_modules", "target" } }
    use 'udalov/kotlin-vim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' } } }
    use 'mfussenegger/nvim-jdtls'
    use 'terrortylor/nvim-comment'
    use 'mfussenegger/nvim-dap'
    use 'alexghergh/nvim-tmux-navigation'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                trigger_events = { "BufLeave" },
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if
                        fn.getbufvar(buf, "&modifiable") == 1 and
                        utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true
                    end
                    return false
                end,
            }
        end,
    })
end)
