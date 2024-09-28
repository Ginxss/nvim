return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	keys = {
		-- Using require("telescope.builtin") here causes telescope to be loaded at startup.
		-- Setting this as the lazy load event and initializing the keybindings in config is ok
		-- because neovim/lazy.nvim finishes loading the plugin before reading the next input.
		-- Tested with simulated immediate keypresses.
		{ "<leader>f" },
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
		})
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fg", builtin.git_status, {})
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})
		vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})
	end,
}
