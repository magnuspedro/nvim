-- Installs language servers (mason-lspconfig), jdtls (nvim-java) and the tools below
local tools = {
    "stylua", -- conform
    "goimports", -- conform
    "delve", -- nvim-dap (Go)
}

return {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
    config = function(_, opts)
        require("mason").setup(opts)

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
