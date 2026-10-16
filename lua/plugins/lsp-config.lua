local java_home = vim.fn.expand("~/.local/share/mise/installs/java/")

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = { border = "rounded", source = true },
            })

            -- Shared by every server
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            vim.lsp.config("jdtls", {
                settings = {
                    java = {
                        configuration = {
                            -- JDKs available to projects (picked by the project's source/target level)
                            runtimes = {
                                { name = "JavaSE-11", path = java_home .. "zulu-11" },
                                { name = "JavaSE-17", path = java_home .. "zulu-javafx-17" },
                                { name = "JavaSE-21", path = java_home .. "openjdk-21" },
                                { name = "JavaSE-25", path = java_home .. "openjdk-25", default = true },
                            },
                        },
                    },
                },
            })

            -- Installs servers and calls vim.lsp.enable() for every Mason-installed one
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "terraformls",
                    "kotlin_language_server",
                    "gopls",
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(ev)
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
                    end

                    map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
                    map("n", "gd", vim.lsp.buf.definition, "Goto definition")
                    map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
                    map("n", "<leader>gd", function() Snacks.picker.lsp_references() end, "Pick references")
                    map("n", "<leader>gi", function() Snacks.picker.lsp_implementations() end, "Pick implementations")
                    map("n", "K", vim.lsp.buf.hover, "Hover")
                    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                    map("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "List workspace folders")
                    map("n", "<leader>D", vim.lsp.buf.type_definition, "Goto type definition")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
                    map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
                end,
            })
        end,
    },
    {
        "nvim-java/nvim-java",
        ft = "java",
        config = function()
            require("java").setup({
                -- Run jdtls on the mise JDK instead of downloading one
                jdk = {
                    auto_install = false,
                    path = java_home .. "openjdk-25",
                },
            })
            vim.lsp.enable("jdtls")
        end,
    },
    {
        -- Teaches lua_ls about the Neovim API and installed plugins
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },
}
