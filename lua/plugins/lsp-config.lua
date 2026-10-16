return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "terraformls",
                "kotlin_language_server",
                "gopls",
            },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
        },
    },
    { 'nvim-java/nvim-java', opts = {} },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
            })
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
            })
            vim.lsp.config("pyright", {
                capabilities = capabilities,
            })
            vim.lsp.config("terraformls", {
                capabilities = capabilities,
            })
            vim.lsp.config("kotlin_lsp", {
                capabilities = capabilities,
            })
            vim.lsp.config("gopls", {
                capabilities = capabilities,
            })
            vim.lsp.config("htmx", {
                capabilities = capabilities,
            })
            vim.lsp.config("jdtls", {
                capabilities = capabilities,
            })

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition) -- builtin.lsp_definitions)
            vim.keymap.set("n", "<leader>gd", function() Snacks.picker.lsp_references() end)
            vim.keymap.set("n", "<leader>gi", function() Snacks.picker.lsp_implementations() end)
            vim.keymap.set("n", "K", vim.lsp.buf.hover)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
            vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end)
        end,
    },
}
