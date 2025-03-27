return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			view = {
				width = 50,
				relativenumber = true,
			},
			filters = {
				git_ignored = false,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			modified = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		})

		vim.g.default_leader_e_mapping = "<CMD>NvimTreeFindFileToggle<CR>"
		vim.keymap.set("n", "<leader>e", vim.g.default_leader_e_mapping)
	end,
}
