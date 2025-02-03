return {
	"stevearc/dressing.nvim",
	enabled = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		input = {
			start_mode = "normal",
		},
	},
}
