return {
	"stevearc/conform.nvim",
	enabled = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			rust = { "rustfmt" },
			lua = { "stylua" },
		},
	},
}
