return {
	"windwp/nvim-ts-autotag",
	cond = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		opts = {
			enable_close_on_slash = true,
		},
	},
}
