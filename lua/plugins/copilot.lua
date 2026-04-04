return {
    { "github/copilot.vim" },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
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
                    }
                }
            },
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
        },
    }
}
