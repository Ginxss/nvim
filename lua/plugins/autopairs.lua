return {
	"windwp/nvim-autopairs",
	cond = not vim.g.profile_light,
	event = "InsertEnter",
	config = true,
}
