return {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship the prebuilt Rust fuzzy matcher
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        -- <CR> accept, <C-Space> open, <C-e> close, <C-n>/<C-p> select, <C-b>/<C-f> scroll docs,
        -- <Tab> accepts a Copilot suggestion, otherwise jumps to the next snippet field
        keymap = {
            preset = "enter",
            ["<Tab>"] = {
                function() return vim.lsp.inline_completion.get() end,
                "snippet_forward",
                "fallback",
            },
        },
        completion = {
            menu = { border = "rounded" },
            documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        },
        -- Signature help comes from Noice (auto-opens on `(` / `,`, <C-s> to show it)
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
