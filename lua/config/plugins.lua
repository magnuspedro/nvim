local opts = {}
local plugins = {
    -- Catppuccin Theme
    { 'catppuccin/nvim',        name = 'catppuccin', priority = 1000 },
    -- Telescope search
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim' }
    },
    -- Toggle comment
    { 'terrortylor/nvim-comment' },
    -- Navigation with Tmux
    { 'alexghergh/nvim-tmux-navigation' },
    -- Auto close pairs
    { 'windwp/nvim-autopairs',          event = 'InsertEnter', opts = {} },
    -- LSP
    { 'neovim/nvim-lspconfig' },
    -- Mason to install languages servers
    { 'williamboman/mason.nvim' },
    -- LSP config for Java
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
                'williamboman/mason.nvim',
                opts = {
                    registries = {
                        'github:nvim-java/mason-registry',
                        'github:mason-org/mason-registry',
                    },
                },
            }
        },
    },
    -- Completition Config
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp' }
    },
}


require('lazy').setup(plugins, opts)
