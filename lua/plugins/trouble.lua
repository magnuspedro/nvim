-- IntelliJ-style tool windows:
--   Problems     (Alt+6)      -> <leader>tp project / <leader>tf current file
--   Find Usages  (Alt+F7)     -> gr
--   Structure    (Cmd+7)      -> <leader>ts
--   Call Hierarchy (Ctrl+Alt+H) -> <leader>ch
--   Next/prev problem (F2 / Shift+F2) -> ]e / [e
--   Next/prev item in tool window (Ctrl+Alt+Down/Up) -> ]t / [t
return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        keys = {
            ["<esc>"] = "close",
        },
        modes = {
            lsp_references = {
                focus = true,
                params = { include_declaration = false },
            },
            lsp_incoming_calls = {
                focus = true,
            },
            symbols = {
                focus = false,
                win = { position = "right", size = 40 },
            },
        },
    },
    keys = {
        { "<leader>tp", "<cmd>Trouble diagnostics toggle<cr>", desc = "Problems (project)" },
        { "<leader>tf", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Problems (current file)" },
        { "<leader>ts", "<cmd>Trouble symbols toggle<cr>", desc = "Structure" },
        { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
        { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
        { "<leader>ch", "<cmd>Trouble lsp_incoming_calls<cr>", desc = "Call hierarchy" },
        { "gr", "<cmd>Trouble lsp_references<cr>", desc = "Find usages" },
        { "]e", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next problem" },
        { "[e", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous problem" },
        {
            "]t",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    pcall(vim.cmd.cnext)
                end
            end,
            desc = "Next item",
        },
        {
            "[t",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    pcall(vim.cmd.cprev)
                end
            end,
            desc = "Previous item",
        },
    },
    init = function()
        -- Show quickfix lists (:grep, :make, LSP, ...) in Trouble instead of the builtin window
        vim.api.nvim_create_autocmd("QuickFixCmdPost", {
            callback = function()
                vim.cmd("Trouble qflist open")
            end,
        })
        vim.api.nvim_create_autocmd("BufRead", {
            callback = function(ev)
                if vim.bo[ev.buf].buftype ~= "quickfix" then
                    return
                end
                local info = vim.fn.getwininfo(vim.fn.bufwinid(ev.buf))[1]
                local is_loclist = info and info.loclist == 1
                vim.schedule(function()
                    if is_loclist then
                        vim.cmd("lclose")
                        vim.cmd("Trouble loclist open")
                    else
                        vim.cmd("cclose")
                        vim.cmd("Trouble qflist open")
                    end
                end)
            end,
        })
    end,
}
