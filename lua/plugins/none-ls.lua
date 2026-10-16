return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
        local builtins = require("null-ls").builtins
        return {
            sources = {
                builtins.formatting.stylua,
                builtins.formatting.gofmt,
            },
        }
    end,
}
