return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        explorer = { enabled = true, replace_netrw = true },
        input = { enabled = true }, -- vim.ui.input (LSP rename, ...) in a floating box
        bigfile = { enabled = true }, -- disable LSP, Treesitter, ... on huge files
        quickfile = { enabled = true }, -- render `nvim file` before plugins load
        words = { enabled = true }, -- highlight LSP references of the word under the cursor, like IntelliJ
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
                trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
            },
            win = {
                -- <a-t>: send results to Trouble (like IntelliJ "Open in Find Window")
                input = { keys = { ["<a-t>"] = { "trouble_open", mode = { "n", "i" } } } },
            },
        },
    },
    keys = {
        { "<C-Bslash>", function() Snacks.explorer() end, mode = { "n", "v" }, desc = "File tree" },
        { "<C-p>", function() Snacks.picker.files() end, desc = "Goto file" },
        { "<C-f>", function() Snacks.picker.grep() end, desc = "Find in path" },
        { "<leader>s", function() Snacks.picker.buffers() end, desc = "Switcher" },
        { "<leader>q", function() Snacks.bufdelete() end, desc = "Close buffer, keep window" },
        { "<leader>/", function() Snacks.picker.lines() end, desc = "Find in file" },
        { "z=", function() Snacks.picker.spelling() end, desc = "Spell suggest" },
        { "<leader>km", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" },
    },
}
