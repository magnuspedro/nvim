return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            ui_select = true,
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
