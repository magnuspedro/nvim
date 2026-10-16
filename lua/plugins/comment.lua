-- Commenting is built into Neovim (gc / gcc); ts-comments picks the right comment style
-- for the code under the cursor (JSX in JS, <script> in HTML, code blocks in markdown, ...)
return {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
}
