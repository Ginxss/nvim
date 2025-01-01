return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle },
	},
	config = function()
		vim.g.undotree_SetFocusWhenToggle = 1

		if vim.g.is_windows then
			vim.g.undotree_DiffCommand = "FC"
		end
	end,
}
