return {
	name = "spy.nvim",
	cond = not vim.g.profile_light,
	dir = ".",
	main = "plugins_local.spy",
	--- @type spy.OptionsNullable
	opts = {
		focus_keymap = "<leader>i",
	},
	keys = { {
		"<leader>i",
		function()
			require("plugins_local.spy").peek_implementation()
		end,
	} },
}
