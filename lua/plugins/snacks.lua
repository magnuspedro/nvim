return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        explorer = { enabled = true, replace_netrw = true },
        picker = {
            enabled = true,
            ui_select = true,
            sources = {
                explorer = {
                    -- libuv file watchers make quitting Neovim hang for 10s+ on macOS; the tree still
                    -- refreshes on save, press `u` in it after external changes (git checkout, builds)
                    watch = false,
                    follow_file = true, -- reveal the current buffer, like IntelliJ "Always Select Opened File"
                },
            },
            actions = {
                trouble_open = function(...)
                    return require("trouble.sources.snacks").actions.trouble_open.action(...)
                end,
            },
            win = {
                -- <a-t>: send results to Trouble (like IntelliJ "Open in Find Window")
                input = { keys = { ["<a-t>"] = { "trouble_open", mode = { "n", "i" } } } },
            },
        },
    },
    keys = {
        { "<C-Bslash>", function() Snacks.explorer() end, mode = { "n", "v" }, desc = "File tree" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>gf", function() Snacks.picker.grep() end, desc = "Live grep" },
        { "<C-p>", function() Snacks.picker.files() end, desc = "Goto file" },
        { "<C-f>", function() Snacks.picker.grep() end, desc = "Find in path" },
        { "<leader>s", function() Snacks.picker.buffers() end, desc = "Switcher" },
        { "<leader>/", function() Snacks.picker.lines() end, desc = "Find in file" },
        { "z=", function() Snacks.picker.spelling() end, desc = "Spell suggest" },
        { "<leader>km", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
}
