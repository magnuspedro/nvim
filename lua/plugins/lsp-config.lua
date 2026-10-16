local java_home = vim.fn.expand("~/.local/share/mise/installs/java/")

-- IntelliJ "Go to Declaration": jump to the declaration, or show usages when already on it
local function goto_declaration_or_usages()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]
    local uri = vim.uri_from_bufnr(bufnr)

    local function on_declaration(results)
        for _, res in pairs(results) do
            local locations = res.result or {}
            if locations.uri or locations.targetUri then
                locations = { locations }
            end
            for _, loc in ipairs(locations) do
                local range = loc.targetSelectionRange or loc.range
                if (loc.targetUri or loc.uri) == uri and range
                    and range.start.line == row and range.start.character <= col and col <= range["end"].character
                then
                    return true
                end
            end
        end
        return false
    end

    vim.lsp.buf_request_all(bufnr, "textDocument/definition", function(client)
        return vim.lsp.util.make_position_params(0, client.offset_encoding)
    end, function(results)
        if on_declaration(results) then
            Snacks.picker.lsp_references()
        else
            Snacks.picker.lsp_definitions()
        end
    end)
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp", -- registers completion capabilities for every server
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = { border = "rounded", source = true },
            })

            vim.lsp.config("*", {
                -- Don't let servers register file watchers: on macOS closing them blocks quitting
                -- for 15s+ with jdtls/spring-boot. Servers still see every change made in Neovim.
                capabilities = {
                    workspace = { didChangeWatchedFiles = { dynamicRegistration = false } },
                },
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
                -- stylua is also an LSP in Mason; conform runs it as a formatter instead
                automatic_enable = { exclude = { "stylua" } },
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "terraformls",
                    "kotlin_lsp",
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
                    map("n", "gd", goto_declaration_or_usages, "Goto declaration / show usages")
                    -- Jumps when there is one implementation, popup to choose otherwise
                    map("n", "gi", function() Snacks.picker.lsp_implementations() end, "Goto implementation")
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
                end,
            })
        end,
    },
    {
        "nvim-java/nvim-java",
        ft = "java",
        dependencies = {
            -- nvim-java pins this to a 2024 commit that still calls the deprecated client.request()
            { "JavaHello/spring-boot.nvim", commit = "9880be48170a21d97444b1eba75853fd3bad33c3" },
        },
        keys = {
            { "<leader>tm", "<cmd>JavaTestRunCurrentMethod<cr>", ft = "java", desc = "Test method" },
            { "<leader>tc", "<cmd>JavaTestRunCurrentClass<cr>", ft = "java", desc = "Test class" },
            { "<leader>tdm", "<cmd>JavaTestDebugCurrentMethod<cr>", ft = "java", desc = "Debug test method" },
            { "<leader>tdc", "<cmd>JavaTestDebugCurrentClass<cr>", ft = "java", desc = "Debug test class" },
            { "<leader>tr", "<cmd>JavaTestViewLastReport<cr>", ft = "java", desc = "Last test report" },
        },
        config = function()
            require("java").setup({
                -- Run jdtls on the mise JDK instead of downloading one
                jdk = {
                    auto_install = false,
                    path = java_home .. "openjdk-25",
                },
            })
            -- spring-boot.nvim no longer starts its server from setup(); nvim-java doesn't enable it yet
            vim.lsp.enable({ "jdtls", "spring-boot" })
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
