return {
	name = "spy.nvim",
	cond = not vim.g.profile_light,
	dir = ".",
	-- main = "plugins_local.spy", -- can be used with opts = {}
	keys = { {
		"<leader>i",
		function()
			require("plugins_local.spy").peek_implementation()
		end,
	} },
}
