return {
	"folke/todo-comments.nvim",
	cond = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
}
