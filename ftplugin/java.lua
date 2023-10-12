local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/magnus/.workspaces/' .. project_name

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}

vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            "/Users/magnus/.config/nvim-java/vscode-java-test/server/*.jar"
        ),
        "\n"
    )
)

vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            "/Users/magnus/.config/nvim-java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
        ),
        "\n"
    )
)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<A-CR>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local config = {

    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-javaagent:/Users/magnus/.config/nvim-java/lombok/lombok.jar',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '-jar', '/Users/magnus/.config/nvim-java/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', '/Users/magnus/.config/nvim-java/jdt-language-server/config_linux/',
        '-data', workspace_dir
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', "build.gradle" }),

    settings = {
        java = {
            jdt = {
              ls = {
                vmArgs = "-Dserver.port=8081"
              }
            },
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
            --   }
            -- },
            eclipse = {
                downloadSources = true
            },
            configuration = {
                updateBuildConfiguration = "interactive"
            },
            maven = {
                downloadSources = true
            },
            implementationsCodeLens = {
                enabled = true
            },
            referencesCodeLens = {
                enabled = true
            },
            references = {
                includeDecompiledSources = true
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all"
                }
            },
            format = {
                enabled = false
                -- settings = {
                --   profile = "asdf"
                -- }
            }
        },
        signatureHelp = {
            enabled = true
        },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*"
            }
        },
        contentProvider = {
            preferred = "fernflower"
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999
            }
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
            useBlocks = true
        }
    },
    flags = {
        allow_incremental_sync = true
    },

    init_options = {
        bundles = bundles,
    },

    on_attach = on_attach
}

require('jdtls').start_or_attach(config)
require('jdtls.setup').add_commands()

vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua require'jdtls'.test_class()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>jc', '<cmd>lua require\'jdtls\'.compile(\'full\')<cr>', { noremap = true})

vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
