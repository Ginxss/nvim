return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader><leader>e",
			function()
				require("oil").open_float(nil, { preview = { vertical = true } })
			end,
		},
	},
	--- @module 'oil'
	--- @type oil.SetupOpts
	opts = {
		default_file_explorer = false,
		delete_to_trash = true,
		view_options = { show_hidden = true },
		use_default_keymaps = false,
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-CR>"] = { "actions.select", opts = { vertical = true } },
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["<C-p>"] = "actions.preview",
			["<C-q>"] = "actions.refresh",
			["<C-t>"] = { "actions.toggle_trash", mode = "n" },
			-- Does not work yet
			-- ["<C-d>"] = { "actions.preview_scroll_down", mode = "n" },
			-- ["<C-u>"] = { "actions.preview_scroll_up", mode = "n" },
			["<C-c>"] = { "actions.close", mode = "n" },
			["<ESC>"] = { "actions.close", mode = "n" },
			["q"] = { "actions.close", mode = "n" },
		},
		float = {
			max_width = 0.8,
			max_height = 0.9,
		},
	},
}
