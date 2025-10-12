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

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("ts_ls", { capabilities = capabilities })
			vim.lsp.enable("ts_ls")

			vim.lsp.config("gopls", { capabilities = capabilities })
			vim.lsp.enable("gopls")

			vim.lsp.config("sourcekit", {
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
			})
			vim.lsp.enable("sourcekit")

			vim.lsp.config("rust_analyzer", {
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
			vim.lsp.enable("rust_analyzer")
		end,
	},
}
