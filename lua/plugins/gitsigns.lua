-- Change bars in the gutter, like IntelliJ's VCS markers
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ---@module "gitsigns"
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")
            local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next change")
            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous change")
            map("n", "<leader>hp", gitsigns.preview_hunk_inline, "Preview change")
            map("n", "<leader>hr", gitsigns.reset_hunk, "Rollback change")
            map(
                "v",
                "<leader>hr",
                function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                "Rollback selected lines"
            )
            map("n", "<leader>hd", gitsigns.diffthis, "Diff file against index")
            map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame line")
        end,
    },
}
