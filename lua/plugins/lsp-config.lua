return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "hls",
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
            local builtin = require("telescope.builtin")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.hls.setup({
                capabilities = capabilities,
            })
            lspconfig.terraformls.setup({
                capabilities = capabilities,
            })
            lspconfig.kotlin_language_server.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            lspconfig.htmx.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({
                capabilities = capabilities,
                -- settings = {
                --     java = {
                --         configuration = {
                --             runtimes = {
                --                 {
                --                     name = "openjdk-21",
                --                     path = "/Users/magnus/.asdf/installs/java/openjdk-21",
                --                     default = true,
                --                 }
                --             }
                --         }
                --     }
                -- }
            })

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition) -- builtin.lsp_definitions)
            vim.keymap.set("n", "<leader>gd", builtin.lsp_references)
            vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations)
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
            vim.keymap.set("n", "gr", vim.lsp.buf.references)
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end)
        end,
    },
}
