return {
	"lewis6991/gitsigns.nvim",
	enabled = not vim.g.profile_light,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup()

		vim.keymap.set("n", "<leader>gn", function()
			gitsigns.nav_hunk("next")
		end)
		vim.keymap.set("n", "<leader>gp", function()
			gitsigns.nav_hunk("prev")
		end)
		vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk)
		vim.keymap.set("n", "<leader>gb", gitsigns.blame)
		vim.keymap.set("n", "<leader>gB", gitsigns.blame_line)
		vim.keymap.set("n", "<leader>gd", function()
			gitsigns.diffthis(nil, { vertical = true })
			-- Move the cursor the left (the new buffer), so that it can be easily closed with :q
			vim.cmd("wincmd h")
		end)
		vim.keymap.set("n", "<leader>gD", gitsigns.preview_hunk_inline)
		vim.keymap.set("n", "<leader>gs", gitsigns.preview_hunk_inline)
	end,
}
