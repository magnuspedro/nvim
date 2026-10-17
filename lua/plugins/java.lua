local java_home = vim.fn.expand("~/.local/share/mise/installs/java/")

return {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = {
        -- nvim-java pins this to a 2024 commit that still calls the deprecated client.request()
        { "JavaHello/spring-boot.nvim", commit = "9880be48170a21d97444b1eba75853fd3bad33c3" },
    },
    keys = {
        { "<leader>tm", "<cmd>JavaTestRunCurrentMethod<cr>", ft = "java", desc = "Test method" },
        { "<leader>tc", "<cmd>JavaTestRunCurrentClass<cr>", ft = "java", desc = "Test class" },
        { "<leader>tdm", "<cmd>JavaTestDebugCurrentMethod<cr>", ft = "java", desc = "Debug test method" },
        { "<leader>tdc", "<cmd>JavaTestDebugCurrentClass<cr>", ft = "java", desc = "Debug test class" },
        { "<leader>tr", "<cmd>JavaTestViewLastReport<cr>", ft = "java", desc = "Last test report" },
    },
    init = function()
        -- Set at startup so it is in place however jdtls gets enabled
        vim.lsp.config("jdtls", {
            settings = {
                java = {
                    configuration = {
                        -- JDKs available to projects (picked by the project's source/target level)
                        runtimes = {
                            { name = "JavaSE-11", path = java_home .. "zulu-11" },
                            { name = "JavaSE-17", path = java_home .. "zulu-javafx-17" },
                            { name = "JavaSE-21", path = java_home .. "openjdk-21" },
                            { name = "JavaSE-25", path = java_home .. "openjdk-25", default = true },
                        },
                    },
                },
            },
        })
    end,
    config = function()
        require("java").setup({
            -- Run jdtls on the mise JDK instead of downloading one
            jdk = {
                auto_install = false,
                path = java_home .. "openjdk-25",
            },
        })
        -- spring-boot.nvim no longer starts its server from setup(); nvim-java doesn't enable it yet
        vim.lsp.enable({ "jdtls", "spring-boot" })
    end,
}
