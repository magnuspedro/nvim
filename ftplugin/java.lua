local home = vim.fn.expand("$HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.workspaces/" .. project_name

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local getOs = function()
	local os = vim.loop.os_uname().sysname
	if os == "Linux" then
		return "config_linux/"
	elseif os == "Darwin" then
		return "config_mac_arm/"
	elseif os == "Windows" then
		return "config_win/"
	end
end

local bundles = {}

vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), "\n")
)

vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			home
				.. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
		),
		"\n"
	)
)

local config = {

	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-javaagent:" .. home .. "/.local/share/java/lombok.jar",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/" .. getOs(),
		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			jdt = {
				ls = {
					vmArgs = "-Dserver.port=8080",
				},
			},
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			format = {
				enabled = false,
				-- settings = {
				--   profile = "asdf"
				-- }
			},
		},
		signatureHelp = {
			enabled = true,
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		contentProvider = {
			preferred = "fernflower",
		},
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
	flags = {
		allow_incremental_sync = true,
	},

	init_options = {
		bundles = bundles,
	},

	on_attach = function(client, bufnr)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
}

require("jdtls").start_or_attach(config)
require("jdtls.setup").add_commands()

vim.cmd(
	"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
vim.cmd(
	"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
)
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")

vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua require'jdtls'.test_class()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>jc", "<cmd>lua require'jdtls'.compile('full')<cr>", { noremap = true })
