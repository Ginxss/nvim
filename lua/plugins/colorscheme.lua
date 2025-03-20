return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- main colorscheme should be loaded asap -> lazy = false and priority = 1000
		config = function()
			require("catppuccin").setup({
				styles = {
					conditionals = {}, -- removed italic
				},
				-- To treat builtin functions like regular functions:
				-- custom_highlights = function(colors)
				-- 	return {
				-- 		["@function.builtin"] = { link = "Function" }
				-- 	}
				-- end,
			})

			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"folke/tokyonight.nvim",
		cond = not vim.g.profile_light,
		lazy = true, -- manually required by telescope when opening colorscheme picker
		config = function()
			require("tokyonight").setup({
				styles = {
					keywords = { italic = false },
				},
			})

			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
