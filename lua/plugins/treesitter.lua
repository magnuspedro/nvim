return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"html",
			"java",
			"rust",
			"kotlin",
			"go",
			"python",
			"typescript",
			"tsx",
			"hcl",
			"terraform",
			"json",
			"yaml",
			"bash",
			"regex", -- noice
			"markdown", -- noice, render-markdown, codecompanion
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
