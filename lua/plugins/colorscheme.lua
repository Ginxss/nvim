-- the colorscheme should be available when starting Neovim
-- lazy: false and priority = 1000
return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				styles = {
					keywords = { italic = false },
				},
			})

			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
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
}
