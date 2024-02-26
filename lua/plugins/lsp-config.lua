return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			opts = {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			},
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
					"tsserver",
					"pyright",
					"hls",
					"terraformls",
					"kotlin_language_server",
					"gopls",
				},
			})
		end,
	},
	{ "mfussenegger/nvim-jdtls" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.hls.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.kotlin_language_server.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
			vim.keymap.set("n", "gr", vim.lsp.buf.references)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end)
		end,
	},
}
