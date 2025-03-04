-- Maybe try out mini.files?
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 50,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		})

		vim.g.tree_mapping = "<CMD>NvimTreeFindFileToggle<CR>"
		vim.keymap.set("n", "<leader>e", vim.g.tree_mapping)
	end,
}
