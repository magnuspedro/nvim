return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    dependencies = { "mason-org/mason.nvim" }, -- installs stylua and goimports
    keys = {
        {
            "<leader>f",
            function() require("conform").format({ async = true }) end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports" }, -- also applies gofmt formatting
        },
        -- Everything else is formatted by its language server (jdtls, ts_ls, ...)
        default_format_opts = { lsp_format = "fallback" },
    },
}
