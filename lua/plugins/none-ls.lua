return {
    "nvimtools/none-ls.nvim",
    config = function()
        local none_ls = require("null-ls")

        none_ls.setup({
            sources = {
                none_ls.builtins.formatting.stylua,
                none_ls.builtins.formatting.google_java_format,
                none_ls.builtins.formatting.gofmt,
            },
        })
    end,
}
