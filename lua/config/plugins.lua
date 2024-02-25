local opts = {}
local plugins = {
    -- Catppuccin Theme
    { 'catppuccin/nvim',                name = 'catppuccin',   priority = 1000 },
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
    -- Tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- Mason to install languages servers
    { 'williamboman/mason.nvim' },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'L3MON4D3/LuaSnip',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason-lspconfig.nvim'
        }
    },
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
            'rcarriga/nvim-dap-ui',
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
    -- treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- Copillot
    {
        "jellydn/CopilotChat.nvim",
        dependencies = { "zbirenbaum/copilot.lua" }, -- Or { "github/copilot.vim" }
        opts = {
            show_help = "yes",                       -- Show help text for CopilotChatInPlace, default: yes
            debug = false,                           -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
        },
        build = function()
            vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
        end,
        event = "VeryLazy",
    },
    -- Better Quick Fix Window
    { 'kevinhwang91/nvim-bqf' }
}


require('lazy').setup(plugins, opts)
