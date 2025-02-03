return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- Should use local rust_analyzer & rustfmt (rustup). If not possible, install manually via Mason.
			ensure_installed = { "lua_ls" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		enabled = not vim.g.profile_light,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({ capabilities = capabilities })

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							maxLength = 100,
						},
					},
				},
			})
		end,
	},
}
