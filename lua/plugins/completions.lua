return {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship the prebuilt Rust fuzzy matcher
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        -- <CR> accept, <C-Space> open, <C-e> close, <C-n>/<C-p> select, <C-b>/<C-f> scroll docs,
        -- <Tab>/<S-Tab> jump in snippets (falls back to Copilot's <Tab> otherwise)
        keymap = { preset = "enter" },
        completion = {
            menu = { border = "rounded" },
            documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
