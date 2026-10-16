return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = { enabled = true, ui_select = true },
    },
    keys = {
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>gf", function() Snacks.picker.grep() end, desc = "Live grep" },
        { "<C-p>", function() Snacks.picker.git_files() end, desc = "Git files" },
        { "z=", function() Snacks.picker.spelling() end, desc = "Spell suggest" },
        { "<leader>km", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
}
