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
                if
                    (loc.targetUri or loc.uri) == uri
                    and range
                    and range.start.line == row
                    and range.start.character <= col
                    and col <= range["end"].character
                then
                    return true
                end
            end
        end
        return false
    end

    vim.lsp.buf_request_all(
        bufnr,
        "textDocument/definition",
        function(client) return vim.lsp.util.make_position_params(0, client.offset_encoding) end,
        function(results)
            if on_declaration(results) then
                Snacks.picker.lsp_references()
            else
                Snacks.picker.lsp_definitions()
            end
        end
    )
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
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
                    "copilot", -- inline AI suggestions (Neovim's built-in inline completion)
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
                    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                    map(
                        "n",
                        "<leader>wl",
                        function() vim.print(vim.lsp.buf.list_workspace_folders()) end,
                        "List workspace folders"
                    )
                    map("n", "<leader>D", vim.lsp.buf.type_definition, "Goto type definition")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
                    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")

                    -- Copilot ghost text: <Tab> accepts (see blink.lua), <M-]>/<M-[> cycle
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client:supports_method("textDocument/inlineCompletion", ev.buf) then
                        vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })
                        map(
                            "i",
                            "<M-]>",
                            function() vim.lsp.inline_completion.select({ count = 1 }) end,
                            "Next suggestion"
                        )
                        map(
                            "i",
                            "<M-[>",
                            function() vim.lsp.inline_completion.select({ count = -1 }) end,
                            "Previous suggestion"
                        )
                    end
                end,
            })
        end,
    },
}
