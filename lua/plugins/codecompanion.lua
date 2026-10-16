return {
    {
        "olimorris/codecompanion.nvim",
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCLI", "CodeCompanionCmd" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI chat" },
            { "<leader>cp", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI actions" },
        },
        opts = {
            interactions = {
                cli = {
                    agent = "claude_code",
                    agents = {
                        claude_code = {
                            cmd = "claude",
                            args = {},
                            description = "Claude Code CLI",
                        },
                        codex = {
                            cmd = "codex",
                            args = {},
                            description = "OpenAI Codex CLI",
                        },
                    },
                },
            },
            display = {
                chat = {
                    window = {
                        position = "right",
                    },
                },
            },
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
        },
    },
}
