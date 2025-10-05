return {
	{
		"williamboman/mason.nvim",
		cond = not vim.g.profile_light,
		lazy = true,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		cond = not vim.g.profile_light,
		lazy = true,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- Should use local rust_analyzer & rustfmt (rustup). If not possible, install manually via Mason.
			-- Must use local sourcekit, not included in mason
			ensure_installed = { "lua_ls" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.profile_light,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			lspconfig.ts_ls.setup({ capabilities = capabilities })

			lspconfig.gopls.setup({ capabilities = capabilities })

			lspconfig.sourcekit.setup({
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							maxLength = 100,
						},
						procMacro = {
							ignored = {
								leptos_macro = {
									-- "component",
									"server",
									"view", -- overrides treesitter (rstml) highlighting if not ignored
								},
							},
						},
						diagnostics = { disabled = { "proc-macro-disabled" } },
					},
				},
			})
		end,
	},
}
