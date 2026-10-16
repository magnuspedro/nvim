return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000, -- load before other plugins so highlights are ready
    opts = {},
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox")
    end,
}
