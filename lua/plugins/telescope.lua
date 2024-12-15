-- Default keymappings in insert mode:
-- <C-C> close
-- <C-V> open vertical
-- <C-X> open horizontal

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>fo",
			function()
				require("telescope.builtin").oldfiles({ cwd = vim.fn.getcwd() })
			end,
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").git_status()
			end,
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").lsp_references()
			end,
		},
		{
			"<leader>fi",
			function()
				require("telescope.builtin").lsp_implementations()
			end,
		},
		{
			"<leader>fd",
			function()
				require("telescope.builtin").diagnostics()
			end,
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
		{
			"<leader>ft",
			function()
				require("telescope.builtin").treesitter()
			end,
		},
		{
			"<leader>fc",
			function()
				require("tokyonight")
				require("telescope.builtin").colorscheme()
			end,
		},
		{
			"<leader>fn",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
				sorting_strategy = "ascending",
			},
			extensions = {
				fzf = {},
			},
		})
		telescope.load_extension("fzf")
	end,
}
