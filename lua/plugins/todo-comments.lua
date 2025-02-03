return {
	"folke/todo-comments.nvim",
	enabled = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
}
