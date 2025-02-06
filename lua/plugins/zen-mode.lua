return {
	"folke/zen-mode.nvim",
	enabled = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local zen_mode = require("zen-mode")

		zen_mode.setup({
			window = { width = 150 },
		})

		vim.keymap.set("n", "<leader>z", zen_mode.toggle)
	end,
}
