return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    ---@module "noice"
    ---@type NoiceConfig
    opts = {
        lsp = {
            -- Render LSP hover/signature docs with Treesitter markdown
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = true, -- classic bottom cmdline for / and ?
            command_palette = true, -- cmdline and popupmenu together at the top
            long_message_to_split = true,
            lsp_doc_border = true,
        },
    },
    keys = {
        { "<leader>mh", "<cmd>Noice history<cr>", desc = "Message history" },
        { "<leader>md", "<cmd>Noice dismiss<cr>", desc = "Dismiss messages" },
    },
}
