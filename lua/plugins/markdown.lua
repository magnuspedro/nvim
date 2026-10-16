return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
        ---@module "render-markdown"
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "HakonHarnes/img-clip.nvim",
        cmd = "PasteImage",
        ft = { "markdown", "codecompanion" },
        opts = {
            filetypes = {
                codecompanion = {
                    prompt_for_file_name = false,
                    template = "[Image]($FILE_PATH)",
                    use_absolute_path = true,
                },
            },
        },
    },
}
