-- Formatters installed through Mason
local tools = { "stylua", "goimports" }

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    dependencies = { "mason-org/mason.nvim" },
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
            go = { "goimports", "gofmt" },
        },
        -- Everything else is formatted by its language server (jdtls, ts_ls, ...)
        default_format_opts = { lsp_format = "fallback" },
    },
    config = function(_, opts)
        require("conform").setup(opts)

        local registry = require("mason-registry")
        registry.refresh(function()
            for _, name in ipairs(tools) do
                local pkg = registry.get_package(name)
                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end)
    end,
}
