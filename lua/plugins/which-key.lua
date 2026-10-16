return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
        preset = "modern",
        spec = {
            { "<leader>a", group = "claude" },
            { "<leader>c", group = "code" },
            { "<leader>g", group = "goto" },
            { "<leader>h", group = "git changes" },
            { "<leader>m", group = "messages" },
            { "<leader>t", group = "tool windows / tests" },
            { "<leader>w", group = "workspace" },
            { "<leader>b", group = "debug" },
            { "g", group = "goto" },
            { "[", group = "prev" },
            { "]", group = "next" },
        },
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps" },
    },
}
