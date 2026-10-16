return {
    "nvim-mini/mini.icons",
    lazy = true, -- loaded on first require by snacks, trouble, which-key, render-markdown, ...
    opts = {},
    init = function()
        -- Plugins that only know nvim-web-devicons get mini.icons through its mock
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
}
