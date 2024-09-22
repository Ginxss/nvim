return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			rust = { "rustfmt", lsp_format = "fallback" },
			lua = { "stylua" },
		},
	},
}
